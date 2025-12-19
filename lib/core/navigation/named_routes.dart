enum NamedRoutes {
  splash('/'),
  onBoarding('/on-boarding'),

  login('/login'),
  bottomNavBar('/bottom-nav-bar')
  ;

  final String routeName;
  const NamedRoutes(this.routeName);
}
