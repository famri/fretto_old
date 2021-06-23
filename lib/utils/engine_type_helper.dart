import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/vehicules_icons.dart';

class EngineTypeHelper {
  static IconData getEngineTypeIconData(String engineTypeCode) {
    switch (engineTypeCode) {
      case 'SCOOTER':
        return VehiculesIcons.scooter;
      case 'UTILITY':
        return VehiculesIcons.utility;
      case 'PICKUP':
        return VehiculesIcons.pickup;
      case 'BUS':
        return VehiculesIcons.bus;
      case 'MINIBUS':
        return VehiculesIcons.minibus;
      case 'VAN_L1H1':
        return VehiculesIcons.van_l1h1;
      case 'VAN_L2H2':
        return VehiculesIcons.van_l2h2;
      case 'VAN_L3H3':
        return VehiculesIcons.van_l3h3;
      case 'VAN_L4H3':
        return VehiculesIcons.van_l4h3;
      case 'FLATBED_TRUCK':
        return VehiculesIcons.flat_bed;
      case 'BOX_TRUCK':
        return VehiculesIcons.box_truck;
      case 'REFRIGERATED_TRUCK':
        return VehiculesIcons.refrigerated;
      case 'TANKER':
        return VehiculesIcons.tanker;
      case 'DUMP_TRUCK':
        return VehiculesIcons.dump_truck;
      case 'HOOK_LIFT_TRUCK':
        return VehiculesIcons.hooklift;
      case 'CAR_CARRIER':
        return VehiculesIcons.car_carrier;

      default:
        return VehiculesIcons.box_truck;
    }
  }
}
