export default ({ router }) => {
  router.addRoutes([
      { path: '/', redirect: '/intro' },
      { path: '/admin-guide', redirect: '/admin-guide/overview' },
      { path: '/admin-guide/onezone', redirect: '/admin-guide/onezone/quickstart' },
      { path: '/admin-guide/oneprovider', redirect: '/admin-guide/oneprovider/quickstart' }
  ])
}
