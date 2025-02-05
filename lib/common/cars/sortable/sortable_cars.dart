import 'package:adventure_rides/common/cars/sortable/responsive_screens/Desktop/sortable_cars_desktop.dart';
import 'package:adventure_rides/common/cars/sortable/responsive_screens/mobile/sortable_cars_mobile.dart';
import 'package:adventure_rides/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';


class SSortableCars extends StatelessWidget {
  const SSortableCars({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SSiteTemplate(useLayout: false, desktop: SortableCarsDesktop(cars: [],), mobile: SortableCarsMobile(cars: [],));
  }
}
