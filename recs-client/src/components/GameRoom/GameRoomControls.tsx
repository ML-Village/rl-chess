import React from 'react';
import { Button } from '@/components/ui/button';

export const GameRoomControls = () => {
    return (
        <div className="flex justify-between items-center
        w-full mx-2 px-6
        
        ">

            <Button className="px-3 py-5 rounded-lg bg-orange-300/80
            text-blue-950 hover:text-white font-semibold
            ">
                Switch Sides
            </Button>

            <Button className="px-3 py-5 rounded-lg bg-orange-400
            text-blue-950 hover:text-white font-semibold
            ">
                Ready Up
            </Button>
            <Button className="px-3 py-5 rounded-lg bg-orange-400
            text-blue-950 hover:text-white font-semibold
            ">
                Start Game
            </Button>
            <Button className="px-3 py-5 rounded-lg bg-orange-400
            text-blue-950 hover:text-white font-semibold
            ">
                Offer Draw
            </Button>
            <Button className="px-3 py-5 rounded-lg bg-orange-400
            text-blue-950 hover:text-white font-semibold
            ">
                Resign
            </Button>
        </div>
    )
}
