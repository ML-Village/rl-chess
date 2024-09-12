import React from 'react';
import { Button } from "@/components/ui/button";
import { FaChess, FaUserFriends } from "react-icons/fa";
import { useDojo } from "@/dojo/useDojo";
//import { useAccount } from '@starknet-react/core';

export const LobbyControls = () => {
    const {
        setup: {
            clientComponents: { Game, Player },
            client
        },
        account: { account},
    } = useDojo();

    //const { account, address, isConnected } = useAccount();

    const handleCreateGame = async () => {
        console.log("LobbyControls: creating game");
        if (account) {
            try{
                //await create_game(account.account as AccountInterface, 1);
                await client.lobby.create_game({
                    account,
                    game_format_id: 1,
                    invite_expiry: 86400, // 1 day
                });
            }catch(e){
                console.log("error creating game: ", e);
            }
        }else{
            console.log("account not connected");
            //todo: make toast for error message
        }

    }  
    

    return (
        <div className="flex justify-center items-center
            space-x-2
            my-2 py-2
            ">
                    
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
