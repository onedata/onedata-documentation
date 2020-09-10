
module.exports = {
    title: 'Onedata documentation',
    description: 'Onedata documentation description tdo',
    themeConfig: {
	navbar: false,
	sidebar: [
	    {
		title: 'User guide',
		path: '/user-guide/what_is_onedata',
		collasable: false,
		children: [
		'/user-guide/what_is_onedata',
		'/user-guide/user_onedata_101'
		]
	    },
	    {
		title: 'Admin guide',
		path: '/admin-guide/',
		collasable: false,
		children: [
		'/admin-guide/admin-intro'
		]
	    }
	    
	    // '/user-guide/': [
	    // 	{
	    // 	    title: 'User Guide',
	    // 	    collapsable: false,
	    // 	    children: [
	    // 		'getting-started',
	    // 		'workflows'
	    // 	    ]
	    // 	}
	    // ],
	]
    }
};
