import "./App.css";
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { Debug } from '@/pages';

function App() {

  return (
    <>
      <Router>
          <Routes>
              {/* Lobby Page */}
              {/* <Route path="/" element={<LobbyPage/>} /> */}
              <Route path="/" element={<Debug/>} />
              {/* <Route path="/room/:roomId" element={<GameRoom />} /> */}
          </Routes>
      </Router>
    </>
  );
}

export default App;
