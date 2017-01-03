export default [
  {
    path: '/',
    name: 'main-view',
    component: require('components/MainView')
  },
  {
    path: '/notes',
    name: 'note-list',
    component: require('components/NoteList')
  },
  {
    path: '/notes/:id',
    name: 'note-view',
    component: require('components/NoteView')
  },
  {
    path: '*',
    redirect: '/'
  }
]
