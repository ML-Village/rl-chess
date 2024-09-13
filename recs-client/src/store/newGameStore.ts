import {create} from 'zustand';

interface newGameStoreState {
    open: boolean;
    setOpen: (value:boolean) => void;
}
export const useNewGameModalStore = create<newGameStoreState>((set) => ({
    open: true,
    setOpen: (value: boolean) => set({ open: value }),
}));