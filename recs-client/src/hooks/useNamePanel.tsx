import React, {useMemo} from 'react';
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

export const useNamePanel = ({ownerName, ownerPfPurl}:{ownerName: string, ownerPfPurl: string}) => {
    return useMemo(()=>{
        return (
            <div className="flex">
                        <Avatar className="h-10 aspect-square mx-2">
                            <AvatarImage src={ownerPfPurl} alt={"username"} />
                            <AvatarFallback>{ownerName}</AvatarFallback>
                        </Avatar>
                        <span className="mx-2 flex items-center text-xl">
                            {ownerName}
                        </span>
            </div>
        )
    },[ownerName, ownerPfPurl])
}
