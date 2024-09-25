import { FaChessPawn } from "react-icons/fa";
import { GiChessRook } from "react-icons/gi";
import { FaChessKnight } from "react-icons/fa6";
import { FaChessBishop } from "react-icons/fa6";
import { FaChessQueen } from "react-icons/fa6";
import { FaChessKing } from "react-icons/fa6";

export const moveHistoryPieceMap = {
    "P": { symbol: <FaChessPawn/>, color: "w" },
    "N": { symbol: <FaChessKnight/>, color: "w" }, //ascii symbol for knight
    "B": { symbol: <FaChessBishop/>, color: "w" },
    "R": { symbol: <GiChessRook/>, color: "w" },
    "Q": { symbol: <FaChessQueen/>, color: "w" },
    "K": { symbol: <FaChessKing/>, color: "w" },
    "p": { symbol: <FaChessPawn/>, color: "b" },
    "n": { symbol: <FaChessKnight/>, color: "b" },
    "b": { symbol: <FaChessBishop/>, color: "b" },
    "r": { symbol: <GiChessRook/>, color: "b" },
    "q": { symbol: <FaChessQueen/>, color: "b" },
    "k": { symbol: <FaChessKing/>, color: "b" },
}

