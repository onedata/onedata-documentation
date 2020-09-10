
module.exports = {
    title: 'Onedata documentation',
    themeConfig: {
        version: '20.02.1',
        navbar: false,
        sidebar: [
            {
                title: 'Introduction',
                path: '/intro',
                collapsable: true
            },
            {
                title: 'User guide',
                path: '/user-guide/quickstart',
                collapsable: true,
                children: [
                    '/user-guide/quickstart',
                    '/user-guide/overview',
                    '/user-guide/spaces-and-files',
                    '/user-guide/tokens'
                ]
            },
            {
                title: 'Admin guide',
                path: '/admin-guide/overview',
                collapsable: true,
                children: [
                    '/admin-guide/overview',
                    {
                        title: 'Onezone',
                        collapsable: false,
                        path: '/admin-guide/onezone/quickstart',
                        children: [
                            '/admin-guide/onezone/quickstart',
                            '/admin-guide/onezone/overview',
                            '/admin-guide/onezone/installation',
                            '/admin-guide/onezone/maintenance'
                        ]
                    },
                    {
                        title: 'Oneprovider',
                        collapsable: false,
                        path: '/admin-guide/oneprovider/quickstart',
                        children: [
                            '/admin-guide/oneprovider/quickstart',
                            '/admin-guide/oneprovider/overview',
                            '/admin-guide/oneprovider/installation',
                            '/admin-guide/oneprovider/maintenance',
                            '/admin-guide/oneprovider/dns-config',
                            '/admin-guide/oneprovider/storages',
                            '/admin-guide/oneprovider/space-supports',
                            '/admin-guide/oneprovider/storage-import'
                        ]
                    }
                ]
            }       
        ]
    }
};
