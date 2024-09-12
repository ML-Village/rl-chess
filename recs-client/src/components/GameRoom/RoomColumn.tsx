import React from 'react';
import { TitleBar } from '@/components/GameRoom';

export const RoomColumn = ({ownerName, inviteeName}:{ownerName: string, inviteeName: string}) => {
    return (
        <div className="flex flex-col
                justify-start items-center h-full w-full
                rounded-2xl overflow-hidden
                text-white bg-slate-900/70
                border-4 border-gray-700">
            
            <TitleBar ownerName={ownerName} inviteeName={inviteeName} />

            <div className="w-full h-[80%]
            ">Chat Box</div>

            <div className="w-full h-[20%]
            ">Chat Input</div>
        </div>
    )
}
