export default [
  {
    path: '/',
    name: 'landing-page',
    component: require('components/LandingPageView')
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
