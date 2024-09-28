import { moveHistoryPieceMap } from '../constants/moveHistoryPieceMap';
import { History } from '@/dojo/typescript/models.gen'; // import interface

export const parseMoveHistory = (move_string: string) => {
    if (move_string.length >= 3 && move_string[0] != '0' && move_string.length<5) {
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

export const getLastMoveString = (historyObject: History) => {
    const move_history_string = historyObject.move_history_string;
    const move_history_array = move_history_string.split('. ');
    const last_move_string_array = move_history_array[move_history_array.length - 1].replace(" / ","").split(' ');
    const last_move_string = last_move_string_array.length >1 ? last_move_string_array[1] : last_move_string_array[0];
    return last_move_string;
}