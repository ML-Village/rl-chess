import manifest from "../contracts/manifests/dev/deployment/manifest.json";

import { createDojoConfig } from "@dojoengine/core";

export const dojoConfig = createDojoConfig({
  manifest,
  //toriiUrl: import.meta.env.VITE_USECONTROLLER ? import.meta.env.VITE_TORII_ADDRESS : "https://localhost:8080/",
});
