import $ from "https://deno.land/x/dax@0.35.0/mod.ts";
import { defineTask } from "https://deno.land/x/dotstingray@v0.2.1/core/mod.ts";
import { link } from "https://deno.land/x/dotstingray@v0.2.1/utils/mod.ts";
import chalk from "npm:chalk@5.3.0";

const home = Deno.env.get("HOME");

if (!home) throw new Error("$HOME is not set!");

const deploy = defineTask([
  link({
    source: "./starship/starship.toml",
    destination: `${home}/.config/starship.toml`,
  }),
  link({
    source: "./sheldon/plugins.toml",
    destination: `${home}/.config/sheldon/plugins.toml`,
  }),
  link({
    source: "./nvim/",
    destination: `${home}/.config/nvim/`,
  }),
  link({
    source: "./zsh/rc",
    destination: `${home}/.zshrc`,
  }),
]);

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
};

const nvimBuild = async () => {
};

if (Deno.args.includes("deploy")) {
  if (Deno.args.includes("run")) {
    const result = await deploy.run();

    const success = result.filter((res) => res.check.ok);
    const fail = result.filter((res) => !res.check.ok);
    if (result.length === success.length) {
      $.log(chalk.green("☑ Symbolic link has been created!"));
      success.map((r) => {
        $.log(chalk.green("+", chalk.white(r.check.name)));
      });
      fail.map((r) => {
        $.log(chalk.red("×", chalk.white(r.check.name)));
      });
      Deno.exit(0);
    } else if (result.length === fail.length) {
      $.log(chalk.red("✖ Symbolic links were not created properly!"));
      fail.map((r) => {
        $.log(chalk.red("×", chalk.white(r.check.name)));
      });
      Deno.exit(1);
    } else {
      $.log(
        chalk.yellow("△ Some symbolic links were not created properly."),
      );
      success.map((r) => {
        $.log(chalk.green("+", chalk.white(r.check.name)));
      });
      fail.map((r) => {
        $.log(chalk.red("×", chalk.white(r.check.name)));
      });
    }
  } else {
    const check = await deploy.check();
    console.log(check);
  }
} else if (Deno.args.includes("tool-install")) {
  toolInstall();
} else if (Deno.args.includes("nvim-build")) {
  nvimBuild();
} else {
  console.log(`unknown commands: ${Deno.args}`);
  Deno.exit(1);
}
