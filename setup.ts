import $ from "https://deno.land/x/dax@0.35.0/mod.ts";
import { defineTask } from "https://deno.land/x/dotstingray@v0.2.1/core/mod.ts";
import { link } from "https://deno.land/x/dotstingray@v0.2.1/utils/mod.ts";

const home = Deno.env.get("HOME");

if (!home) throw new Error("$HOME is not set!");

const deploy = defineTask([
  link({
    source: "./starship/starship.toml",
    destination: `${home}/.config/starship.toml`,
  }),
]);

if (Deno.args.includes("deploy")) {
  if (Deno.args.includes("run")) {
    await deploy.run();
  } else {
    const check = await deploy.check();
    console.log(check);
  }
} else {
  console.log(`unknown commands: ${Deno.args}`);
  Deno.exit(1);
}
