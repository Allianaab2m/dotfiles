import $ from "https://deno.land/x/dax@0.35.0/mod.ts";
import { defineTask } from "https://deno.land/x/dotstingray@v0.2.1/core/mod.ts";
import chalk from "npm:chalk@5.3.0";
import { createTasks } from "./tasks.ts";

const home = Deno.env.get("HOME");

if (!home) throw new Error("$HOME is not set!");

const deploy = defineTask(await createTasks());

const installWithRtx = async (name: string, version = "latest") => {
  $.log(chalk.cyan(`> Installing ${name}`));
  if ($.commandExistsSync(name)) {
    $.log(chalk.cyan(`>>> ${name} has been already installed.`));
  } else {
    await $`rtx install ${name}@${version}`;
    await $`rtx global ${name}@${version}`;
    $.log(chalk.blue(`>>> Installed ${name}!`));
  }
};

const toolInstall = async () => {
  // Sheldon Install
  $.log(chalk.cyan("> Installing Sheldon..."));
  await $`cargo install sheldon`;
  // lsd Install
  $.log(chalk.cyan("> Installing lsd..."));
  await $`cargo install lsd`;

  // ghq Install
  await installWithRtx("ghq");

  // GoLang Install
  await installWithRtx("go");

  // Node.js + pnpm install
  await installWithRtx("node", "lts");
  await installWithRtx("pnpm");

  // github-cli install
  await installWithRtx("github-cli");
};

const nvimBuild = async () => {
  if ($.commandExistsSync("ghq") === false) {
    console.log("ghq not installed");
    Deno.exit(1);
  }

  await $`ghq get https://github.com/neovim/neovim`;
  await $`sudo pacman -S base-devel cmake unzip ninja curl`;
  await $`make CMAKE_BUILD_TYPE=RelWithDebInfo`.cwd(
    `${home}/ghq/github.com/neovim/neovim`,
  );
  await $`sudo make install`.cwd(`${home}/ghq/github.com/neovim/neovim`);
};

if (Deno.args.includes("deploy")) {
  if (Deno.args.includes("run")) {
    await deploy.run();
  } else {
    const check = await deploy.check();

    const success = check.filter((c) => c.ok);
    const fail = check.filter((c) => !c.ok);
    if (check.length === success.length) {
      $.log(chalk.green("☑ Symbolic link has been created!"));
      success.map((r) => {
        $.log(chalk.green("+", chalk.white(r.name)));
      });
      fail.map((r) => {
        $.log(chalk.red("×", chalk.white(r.name)));
      });
      Deno.exit(0);
    } else if (check.length === fail.length) {
      $.log(chalk.red("✖ Symbolic links were not created properly!"));
      fail.map((r) => {
        $.log(chalk.red("×", chalk.white(r.name)));
      });
      Deno.exit(1);
    } else {
      $.log(
        chalk.yellow("△ Some symbolic links were not created properly."),
      );
      success.map((r) => {
        $.log(chalk.green("+", chalk.white(r.name)));
      });
      fail.map((r) => {
        $.log(chalk.red("×", chalk.white(r.name)));
      });
    }
  }
} else if (Deno.args.includes("tool-install")) {
  toolInstall();
} else if (Deno.args.includes("nvim-build")) {
  nvimBuild();
} else {
  console.log(`unknown commands: ${Deno.args}`);
  Deno.exit(1);
}
