import "./App.css";
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { BaseNavbar } from "@/components";
import { Debug, LobbyPage, GameRoom } from '@/pages';

// dojo stuff
import { useQuerySync } from "@dojoengine/react";
import { useDojo } from "./dojo/useDojo";

function App() {
  
  const {
    setup: {
      toriiClient,
      contractComponents,
    },
    //account
  } = useDojo();

  useQuerySync(toriiClient, contractComponents as any, []);


  return (
    <>
      <Router>
        <div className="flex flex-col h-screen">
            <BaseNavbar />
            <Routes>
                {/* Lobby Page */}
                <Route path="/" element={<LobbyPage/>} />
                <Route path="/debug" element={<Debug/>} />
                <Route path="/room/:roomId" element={<GameRoom />} />
            </Routes>
          </div>
      </Router>
    </>
  );
}

export default App;
