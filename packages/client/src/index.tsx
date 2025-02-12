import mudConfig from "contracts/mud.config";
import ReactDOM from "react-dom/client";
import "../index.css";
import { App } from "./App";
import { WandererProvider } from "./contexts/WandererContext";
import { setup } from "./mud/setup";
import { MUDProvider } from "./MUDContext";
import "./index.css";

const rootElement = document.getElementById("react-root");
if (!rootElement) throw new Error("React root not found");
const root = ReactDOM.createRoot(rootElement);

setup().then(async (result) => {
  root.render(
    <MUDProvider value={result}>
      <WandererProvider>
        <div className="bg-dark-600 w-full h-screen">
          {" "}
          {/* фиксированная высота */}
          <App />
        </div>
      </WandererProvider>
    </MUDProvider>,
  );

  if (import.meta.env.DEV) {
    const { mount: mountDevTools } = await import("@latticexyz/dev-tools");
    mountDevTools({
      config: mudConfig,
      publicClient: result.network.publicClient,
      walletClient: result.network.walletClient,
      latestBlock$: result.network.latestBlock$,
      storedBlockLogs$: result.network.storedBlockLogs$,
      worldAddress: result.network.worldContract.address,
      worldAbi: result.network.worldContract.abi,
      write$: result.network.write$,
      useStore: result.network.useStore,
    });
  }
});
