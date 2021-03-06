import ReactOnRails from 'react-on-rails';
import SearchPageStore from '../store/searchPageStore';
import SearchPageApp from './SearchPageApp';
import SearchInputApp from './SearchInputApp';

function searchPageStore(props, context) {
  return SearchPageStore;
}

ReactOnRails.register({ SearchPageApp })
ReactOnRails.register({ SearchInputApp })
ReactOnRails.registerStore({ searchPageStore })
