import { moveHistoryPieceMap } from '../constants/moveHistoryPieceMap';

export const parseMoveHistory = (move_string: string) => {
    if (move_string.length >= 3 && move_string[0] != '0') {
        const pieceKey = move_string[0] as keyof typeof moveHistoryPieceMap;
        const piece = moveHistoryPieceMap[pieceKey];
        return (
            <>
                <span className={`${piece?.color=='w'? "text-white" : "text-black"}
                p-1
                `}>{
                    piece?.symbol}
                </span>
                {move_string.slice(1)}
            </>
        );
    }
    else {
        return (
            <>{move_string}</>
        )
    }
}