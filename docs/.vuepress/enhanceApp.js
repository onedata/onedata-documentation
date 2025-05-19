export default ({ router }) => {
  const originalScrollBehaviour = router.options.scrollBehavior;

  router.addRoutes([
      { path: '/', redirect: '/intro' },
      { path: '/admin-guide', redirect: '/admin-guide/overview' },
      { path: '/admin-guide/onezone', redirect: '/admin-guide/onezone/quickstart' },
      { path: '/admin-guide/oneprovider', redirect: '/admin-guide/oneprovider/quickstart' }
  ])
  router.options.scrollBehavior = function (to, from, savedPosition) {
    if (typeof window.onRouteChange === 'function') {
      window.onRouteChange(to, from);
    }
    return originalScrollBehaviour(to, from, savedPosition);
  };
}
