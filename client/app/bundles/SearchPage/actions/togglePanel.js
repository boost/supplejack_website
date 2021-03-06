import { createAction } from 'redux-actions';
import performSearch from './performSearch';

export const TOGGLE_PANEL = 'TOGGLE_PANEL';
const togglePanel = createAction(TOGGLE_PANEL);

// This is another custom action, refer to filters.js
export default function togglePanelAndSearch() {
  return (dispatch, getState) => {
    dispatch(togglePanel());

    if (!getState().panel.filtersToApply)
      return;

    dispatch(performSearch());
  };
}
