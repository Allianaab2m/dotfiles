import $ from "https://deno.land/x/dax@0.35.0/mod.ts";
import { link } from "https://deno.land/x/dotstingray@v0.2.1/utils/mod.ts";

const home = Deno.env.get("HOME");

if (!home) throw new Error("$HOME is not set!");

const createLink = (fileName: string) => {
  return link({
    source: `./${fileName}`,
    destination: `${home}/.config/${fileName}`,
  });
};

const nvimFiles = async () => {
  const res = await $`find nvim`.text();
  const tasks = res.split("\n").filter((r) => r.endsWith(".lua")).flatMap((f) =>
    createLink(f)
  );
  return tasks;
};

export const createTasks = async () => {
  return [
    link({
      source: "./starship/starship.toml",
      destination: `${home}/.config/starship.toml`,
    }),
    link({
      source: "./sheldon/plugins.toml",
      destination: `${home}/.config/sheldon/plugins.toml`,
    }),
    link({
      source: "./zsh/rc",
      destination: `${home}/.zshrc`,
    }),
    await nvimFiles(),
  ].flat();
};
