import {create} from 'zustand';

interface newGameStoreState {
    open: boolean;
    setOpen: (value:boolean) => void;
}
export const useNewGameModalStore = create<newGameStoreState>((set) => ({
    open: false,
    setOpen: (value: boolean) => set({ open: value }),
}));