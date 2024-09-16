import React from 'react';
import { Button } from "@/components/ui/button";
import { FaChess, FaUserFriends } from "react-icons/fa";
import { useDojo } from "@/dojo/useDojo";
import { useNewGameModalStore } from "@/store";
import { CreateGameModal } from "@/components/Modals";
//import { useAccount } from '@starknet-react/core';

export const LobbyControls = () => {
    const {
        setup: {
            clientComponents: { Game, Player },
            client
        },
        account: { account},
    } = useDojo();
    const { open: createGameModalOpen, setOpen: setCreateGameModalOpen } = useNewGameModalStore();
    //const { account, address, isConnected } = useAccount();

    
    
    const handleCreateGame = () => {
        setCreateGameModalOpen(true);
    }


    return (
        <div className="flex justify-center items-center
            space-x-2
            my-2 py-2
            ">
                    <CreateGameModal />
                    <Button className="text-2xl font-bold
                    p-8 rounded-xl
                    bg-gray-800 hover:bg-orange-600/70
                    "
                    onClick={handleCreateGame}
                    >
                        <FaChess className="text-3xl text-orange-700"/>
                        <span className="mx-3">Create Game</span>
                    </Button>
                    
                    <Button className="text-2xl font-bold
                    p-8 rounded-xl
                    bg-gray-800 hover:bg-orange-600/70
                    ">  
                        
                        <span className="mx-3" >Play A Friend</span>
                        <FaUserFriends className="text-3xl text-orange-700"/>
                    </Button>
                </div>
    )
}
