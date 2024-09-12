import React from 'react';
import { TitleBar, GameRoomControls } from '@/components/GameRoom';
import { Button } from '@/components/ui/button';

export const RoomColumn = ({roomId, ownerName, inviteeName}:{roomId:string, ownerName: string, inviteeName: string}) => {
    return (
        <div className="flex flex-col
                justify-start items-center h-full w-[28vw]
                rounded-2xl overflow-hidden
                text-white bg-gray-800/80
                border-2 border-orange-500">
            
            <TitleBar ownerName={ownerName} inviteeName={inviteeName} />

            <GameRoomControls roomId={roomId}/>

            <div className="w-full
            my-2
            ">
                <div className="
                mx-6 p-4 h-[35vh]
                bg-black/30
                border border-blue-950/80 rounded-lg">
                        Move History
                </div>
            </div>

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
