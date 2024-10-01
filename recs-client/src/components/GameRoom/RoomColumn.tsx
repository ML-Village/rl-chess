import React, { useMemo} from 'react';
import { TitleBar, GameRoomControls, MoveHistoryTable } from '@/components/GameRoom';
import { Button } from '@/components/ui/button';
import { formatAddress } from '@/utils';
import { FaCopy } from "react-icons/fa";

export const RoomColumn = ({roomId, ownerName, inviteeName}:{roomId:string, ownerName: string, inviteeName: string}) => {
    const copyRoomId = () => {
        navigator.clipboard.writeText(roomId)
            // .then(() => {
            //     // Optionally, you can show a notification or tooltip here
            //     console.log('Room ID copied to clipboard');
            // })
            // .catch((err) => {
            //     console.error('Failed to copy room ID: ', err);
            // });
    };

    return (
        <div className="flex flex-col
                justify-start items-center h-full w-[28vw]
                rounded-2xl overflow-hidden
                text-white bg-gray-800/80
                ">
            
            <TitleBar ownerName={ownerName} inviteeName={inviteeName} />
            <div className="w-full px-6 flex justify-start items-center gap-x-1">
                <span>Room Id:</span>
                <span className="text-sm flex items-center py-1">{formatAddress(roomId)}</span>
                <Button className="h-full p-1 text-xs rounded-lg bg-transparent
                hover:bg-white/30"
                onClick={copyRoomId}
                >
                    <FaCopy className="text-white"/>
                </Button>
            </div>
            <GameRoomControls roomId={roomId}/>
            
            {/* Move History Table */}
            {/* <MoveHistoryTable roomId={roomId} /> */}
                {/* Chat Window */}
            <div className="w-full
            flex-1 pb-2
            ">
                <div className="
                flex flex-col justify-start
                mx-6 pb-2 h-full">
                    
                    {/* text window */}
                    <div className="flex flex-col
                    h-full w-full mb-2
                    border border-blue-950/80 rounded-lg
                    bg-black/30
                    ">

                    </div>


                    {/* input window */}
                    <div className="flex 
                    items-center
                    ">
                        <input 
                        className="
                        w-full
                        text-base p-3
                        bg-black/30 overflow-hidden
                        rounded-xl 
                        border border-blue-950/80
                        "
                        type="text" placeholder="Type your message here" />
                        
                        <Button
                        className="mx-1 ml-2
                        px-3
                        rounded-lg
                        bg-orange-500
                        text-blue-950 hover:text-white 
                        font-semibold
                        "
                        >
                            Send
                            </Button>
                    </div>
                </div>
            </div>


        </div>
    )
}
