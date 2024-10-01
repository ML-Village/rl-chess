import { createDojoConfig } from "@dojoengine/core";
//import manifest from "../contracts/manifests/dev/deployment/manifest.json";
import manifest from "../contracts/manifests/slot/deployment/manifest.json"

// const getManifest = async () => {
//   const manifestPath = import.meta.env.VITE_DEPLOYMENT === "slot"
//     ? "../contracts/manifests/slot/deployment/manifest.json"
//     : "../contracts/manifests/dev/deployment/manifest.json";
  
//   return (await import(/* @vite-ignore */ manifestPath)).default;
// };

// export const dojoConfig = async () => {
//   const manifest = await getManifest();
//   console.log("manifest", manifest);

//   return createDojoConfig({
//     manifest: manifest,
//     rpcUrl: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_KATANA_ADDRESS : "http://localhost:5050/",
//     toriiUrl: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_TORII_ADDRESS : "https://localhost:8080/",
//     // masterAddress: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_MASTER_ADDRESS : "0xb3ff441a68610b30fd5e2abbf3a1548eb6ba6f3559f2862bf2dc757e5828ca",
//     // masterPrivateKey: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_MASTER_PRIVATE_KEY : "0x2bbf4f9fd0bbb2e60b0316c1fe0b76cf7a4d0198bd493ced9b8df2a3a24d68a",
//     //toriiUrl: import.meta.env.VITE_USECONTROLLER ? import.meta.env.VITE_TORII_ADDRESS : "https://localhost:8080/",
//   });
// };

export const dojoConfigSlot = createDojoConfig({
  manifest: manifest,
  rpcUrl: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_KATANA_ADDRESS : "http://localhost:5050",
  toriiUrl: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_TORII_ADDRESS : "http://localhost:8080",
  masterAddress: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_MASTER_ADDRESS : "0xb3ff441a68610b30fd5e2abbf3a1548eb6ba6f3559f2862bf2dc757e5828ca",
  masterPrivateKey: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_MASTER_PRIVATE_KEY : "0x2bbf4f9fd0bbb2e60b0316c1fe0b76cf7a4d0198bd493ced9b8df2a3a24d68a",
  //accountClassHash: import.meta.env.VITE_DEPLOYMENT === "slot" ? import.meta.env.VITE_MASTER_ACCOUNT_CLASS_HASH : "0x2427dd10a58850ac9a5ca6ce04b7771b05330fd18f2e481831ad903b969e6b2",
  //toriiUrl: import.meta.env.VITE_USECONTROLLER ? import.meta.env.VITE_TORII_ADDRESS : "https://localhost:8080/",
});
