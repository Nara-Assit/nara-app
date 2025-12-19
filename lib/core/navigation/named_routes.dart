enum NamedRoutes {
  splash('/'),
  onBoarding('/on-boarding'),
  login('/login')
  ;

  final String routeName;
  const NamedRoutes(this.routeName);
}
