mainApp
.constant('AppSettings', {
/*
        state:          state as used ui.router, "-" for separator
        name:           display name 
        accessLevel:    minimum access level required
                        will not render if user access level is less than this value
                        use -1 to display if user is not logged in for login/sigout
        onClick:        onclick function, optional, do not use double quotes
        subMenu:        render as dropdown

    Sample:

    HomeLink: { state: '/home', name: 'My Site' },
    LeftMenu: [
        { state: '/home', name: 'Onex', accessLevel: 0, onClick: "alert('hello');" },   // items with no subMenu will render top level item
        {
            state: 'two', name: 'Two', accessLevel: 0,                                  // items with subMenu will render as dropdown
            subMenu: [
                { state: 'two', name: 'Two1', accessLevel: 0 },
                { state: 'two', name: 'Two2', accessLevel: 1 },
                { state: '-', name: 'separator', accessLevel: 1 },
                { state: 'two', name: 'Two4', accessLevel: 0 },
            ]
        },
        {
            state: 'three', name: 'THREEDROP', accessLevel: 1,                    // items with subMenu will render as dropdown
            subMenu: [
                { state: 'xxx', name: 'xxTwo1', accessLevel: 1 },
                { state: 'xxx', name: 'xxTwo2', accessLevel: 1 },
            ]
        }
    ],

    RightMenu: [
        { state: '/login', name: 'Login', accessLevel: -1 },             // show only if user is not logged in (accessLevel -1)
        { state: '/home', name: 'Logout', accessLevel: 1, onClick: "logOut()" },
        { state: '/signup', name: 'Signup', accessLevel: -1 },
    ]
})

*/

    HomeLink: { state: 'home', name: 'CRS' },
    LeftMenu: [
        {
            state: '', name: 'Reports', accessLevel: 1,                      // items with subMenu will render as dropdown
            subMenu: [
                { state: 'report1', name: 'Daily Income', accessLevel: 1 },
                { state: 'report2', name: 'Weekly Income', accessLevel: 1 },
                { state: 'report2', name: 'Monthly Income', accessLevel: 1 },
                { state: '-', name: 'separator', accessLevel: 1 },
                { state: 'report3', name: 'Daily Activity', accessLevel: 1 },
                { state: 'report3', name: 'Weekly Activity', accessLevel: 1 },
            ]
        },
        {
            state: '', name: 'Admin', accessLevel: 1,                    // items with subMenu will render as dropdown
            subMenu: [
                { state: 'category', name: 'Category', accessLevel: 1 },
                { state: '-', name: 'separator', accessLevel: 1 },
                { state: 'restaurant', name: 'Restaurant', accessLevel: 1 },
            ]
        }
    ],

    RightMenu: [
        { state: 'login', name: 'Login', accessLevel: -1 },             // show only if user is not logged in (accessLevel -1)
        { state: 'logout', name: 'Logout', accessLevel: 1, onClick: "logOut()" },
        { state: 'signup', name: 'Signup', accessLevel: -1 },
    ]
})