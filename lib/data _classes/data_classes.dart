import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore with ChangeNotifier, DiagnosticableTreeMixin {
  DataStore(this._userSelectedStocksToNotify) {
    _futureStockItems.clear();

    // Calculate the stock items for the next 7 days
    for (int i = 0; i < 7; i++) {
      DayStock futureDayStock = new DayStock();
      _futureStockItems.add(
        futureDayStock
            .calculatedDayStock(DateTime.now().toUtc().add(Duration(days: i))),
      );
    }
  }

  List<List<STOCK_ITEM>> _futureStockItems = [];
  List<int> _userSelectedStocksToNotify = [];

  List<List<STOCK_ITEM>> get futureStockItems => _futureStockItems;
  List<int> get userSelectedStocksToNotify {
    return _userSelectedStocksToNotify;
  }

  void saveSelectedList(List<int> integerList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = integerList.map((e) => e.toString()).toList();
    notifyListeners();

    await prefs.setStringList('notifyOnStockList', stringList);
  }

  /// Makes `DataStore` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('count', count));
  // }
}

class SlotAandB {
  SlotAandB(
    this.stockA,
    this.stockB,
  );

  STOCK_ITEM stockA, stockB;

  @override
  String toString() {
    return stockA.toString() + " and " + stockB.toString();
  }
}

class SlotC {
  SlotC(
    this.itemOrderID,
    this.itemMapID,
    this.itemMapName,
  );

  int itemOrderID, itemMapID;
  STOCK_ITEM itemMapName;
}

class DayStock {
  DateTime date;
  SlotAandB slotAandB;
  SlotC slotC;

  List<STOCK_ITEM> dayStock = [];

  List<SlotAandB> slotAandBList = [];
  SlotAandB todaySlotAandB;

  List<SlotC> slotCOrderList = <SlotC>[];
  SlotC todaySlotC;

  List<SlotAandB> populateSlotAandBPattern() {
    List<SlotAandB> list = [
      SlotAandB(
        // 1
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        STOCK_ITEM.TANGLED_FISHBOWL,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        //5
        STOCK_ITEM.ANIMA_CRYSTAL,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.BROKEN_FISHING_ROD,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.ANIMA_CRYSTAL,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        //10
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.SILVERHAWK_DOWN,
      ),
      SlotAandB(
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        STOCK_ITEM.ADVANCED_PULSE_CORE,
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
      ),
      SlotAandB(
        //15
        STOCK_ITEM.TANGLED_FISHBOWL,
        STOCK_ITEM.BROKEN_FISHING_ROD,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        STOCK_ITEM.ADVANCED_PULSE_CORE,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.LIVID_PLANT,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        //20
        STOCK_ITEM.BROKEN_FISHING_ROD,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.ADVANCED_PULSE_CORE,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        //25
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        STOCK_ITEM.ADVANCED_PULSE_CORE,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        //30
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.SILVERHAWK_DOWN,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.ADVANCED_PULSE_CORE,
      ),
      SlotAandB(
        STOCK_ITEM.BROKEN_FISHING_ROD,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        STOCK_ITEM.TANGLED_FISHBOWL,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
      ),
      SlotAandB(
        //35
        STOCK_ITEM.BROKEN_FISHING_ROD,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.SILVERHAWK_DOWN,
      ),
      SlotAandB(
        //40
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        STOCK_ITEM.SILVERHAWK_DOWN,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        //45
        STOCK_ITEM.TANGLED_FISHBOWL,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
      ),
      SlotAandB(
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        //50
        STOCK_ITEM.BROKEN_FISHING_ROD,
        STOCK_ITEM.BROKEN_FISHING_ROD,
      ),
      SlotAandB(
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        //55
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
      ),
      SlotAandB(
        STOCK_ITEM.LIVID_PLANT,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
      ),
      SlotAandB(
        STOCK_ITEM.LIVID_PLANT,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        //60
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        STOCK_ITEM.BROKEN_FISHING_ROD,
        STOCK_ITEM.ANIMA_CRYSTAL,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        //65
        STOCK_ITEM.BROKEN_FISHING_ROD,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.ADVANCED_PULSE_CORE,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        //70
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.BROKEN_FISHING_ROD,
      ),
      SlotAandB(
        STOCK_ITEM.LIVID_PLANT,
        STOCK_ITEM.ANIMA_CRYSTAL,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        STOCK_ITEM.SILVERHAWK_DOWN,
        STOCK_ITEM.SILVERHAWK_DOWN,
      ),
      SlotAandB(
        //75
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.ADVANCED_PULSE_CORE,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.BROKEN_FISHING_ROD,
      ),
      SlotAandB(
        //80
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.LIVID_PLANT,
      ),
      SlotAandB(
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        //85
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        STOCK_ITEM.LIVID_PLANT,
        STOCK_ITEM.SILVERHAWK_DOWN,
      ),
      SlotAandB(
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.ADVANCED_PULSE_CORE,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        STOCK_ITEM.LIVID_PLANT,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        //90
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
      ),
      SlotAandB(
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        STOCK_ITEM.BARREL_OF_BAIT,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.LIVID_PLANT,
      ),
      SlotAandB(
        //95
        STOCK_ITEM.ANIMA_CRYSTAL,
        STOCK_ITEM.SILVERHAWK_DOWN,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
      ),
      SlotAandB(
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
      ),
      SlotAandB(
        //100
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
      SlotAandB(
        STOCK_ITEM.LIVID_PLANT,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.LIVID_PLANT,
      ),
      SlotAandB(
        STOCK_ITEM.ADVANCED_PULSE_CORE,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        //105
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.ANIMA_CRYSTAL,
      ),
      SlotAandB(
        STOCK_ITEM.ADVANCED_PULSE_CORE,
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.SACRED_CLAY,
      ),
      SlotAandB(
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        //110
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
      ),
      SlotAandB(
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL,
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
      ),
      SlotAandB(
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        STOCK_ITEM.GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.UNSTABLE_AIR_RUNE,
      ),
      SlotAandB(
        STOCK_ITEM.SHATTERED_ANIMA,
        STOCK_ITEM.BROKEN_FISHING_ROD,
      ),
      SlotAandB(
        //115
        STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM,
        STOCK_ITEM.BARREL_OF_BAIT,
      ),
      SlotAandB(
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY,
        STOCK_ITEM.SHATTERED_ANIMA,
      ),
      SlotAandB(
        STOCK_ITEM.SLAYER_VIP_COUPON,
        STOCK_ITEM.TANGLED_FISHBOWL,
      ),
      SlotAandB(
        STOCK_ITEM.SACRED_CLAY,
        STOCK_ITEM.ANIMA_CRYSTAL,
      ),
      SlotAandB(
        STOCK_ITEM.ADVANCED_PULSE_CORE,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM,
      ),
      SlotAandB(
        //120
        STOCK_ITEM.GIFT_FOR_THE_REAPER,
        STOCK_ITEM.SLAYER_VIP_COUPON,
      ),
    ];

    return list;
  }

  List<SlotC> populateSlotCPattern() {
    List<SlotC> list = [
      SlotC(
        // 1
        1,
        1,
        STOCK_ITEM.DRAGONKIN_LAMP,
      ),
      SlotC(
        2,
        8,
        STOCK_ITEM.TAIJU,
      ),
      SlotC(
        3,
        3,
        STOCK_ITEM.DEATHTOUCHED_DART,
      ),
      SlotC(
        4,
        7,
        STOCK_ITEM.CRYSTAL_TRISKELION,
      ),
      SlotC(
        //5
        5,
        4,
        STOCK_ITEM.MENAPHITE_GIFT_OFFERING_LARGE,
      ),
      SlotC(
        6,
        11,
        STOCK_ITEM.DUNGEONEERING_WILDCARD,
      ),
      SlotC(
        7,
        10,
        STOCK_ITEM.UNFOCUSED_REWARD_ENHANCER,
      ),
      SlotC(
        8,
        13,
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_MONTHLY,
      ),
      SlotC(
        9,
        12,
        STOCK_ITEM.HARMONIC_DUST,
      ),
      SlotC(
        //10
        10,
        2,
        STOCK_ITEM.DISTRACTION_AND_DIVERSION_WEEKLY,
      ),
      SlotC(
        11,
        9,
        STOCK_ITEM.MESSAGE_IN_A_BOTTLE,
      ),
      SlotC(
        12,
        5,
        STOCK_ITEM.STARVED_ANCIENT_EFFIGY,
      ),
      SlotC(
        13,
        6,
        STOCK_ITEM.LARGE_GOEBIE_BURIAL_CHARM,
      ),
    ];

    return list;
  }

  List<int> slotCFixedFortyDayRotation() {
    return [
      1,
      1,
      2,
      1,
      3,
      4,
      9,
      1,
      8,
      6,
      6,
      6,
      5,
      7,
      8,
      5,
      7,
      9,
      7,
      2,
      4,
      4,
      1,
      4,
      6,
      10,
      4,
      11,
      7,
      2,
      5,
      5,
      9,
      12,
      2,
      9,
      3,
      12,
      4,
      12,
    ];
  }

  List<STOCK_ITEM> calculatedDayStock(DateTime calculateForDate) {
    // Calculate Slot A and B index
    slotAandBList = populateSlotAandBPattern();
    int dateDifferenceInDaysSlotAAndB =
        calculateForDate.difference(DateTime.utc(2018, 03, 11)).inDays;
    int slotAandBIndex = dateDifferenceInDaysSlotAAndB % 120;
    todaySlotAandB = slotAandBList[slotAandBIndex];

    // print("Today's Slot A and B:" + todaySlotAandB.toString());

    // Calculate Slot C index
    // Number of 40-day periods elapsed since 11 March 2018
    int amountOf40RotationDays =
        (calculateForDate.difference(DateTime.utc(2018, 03, 11)).inDays / 40)
            .floor();

    // Number of days elapsed since start of current 40-day cycle
    int elapsedDaysIn40DayCycle =
        calculateForDate.difference(DateTime.utc(2018, 03, 11)).inDays % 40;

    // print("Current Rotation: " + amountOf40RotationDays.toString());

    // print("Elapsed Days in current Rotation: " +
    //     elapsedDaysIn40DayCycle.toString());

    // get the ID of the current item
    int itemOrderID = slotCFixedFortyDayRotation()[elapsedDaysIn40DayCycle];

    // print("itemOrderID: " + itemOrderID.toString());
    //map the current item id to the item order id

    int itemMapID;

    populateSlotCPattern().asMap().forEach(
      (index, element) {
        if (element.itemOrderID == itemOrderID) {
          itemMapID = element.itemMapID;
        }
      },
    );

    // print("itemMapID: " + itemMapID.toString());

    // move mapped ID to current rotation
    int todayMapID = ((itemMapID + amountOf40RotationDays) % 13);
    // print("todayMapID: " + todayMapID.toString());

    if (todayMapID == 0) {
      // pass in 13
      populateSlotCPattern().asMap().forEach(
        (index, element) {
          if (element.itemMapID == 13) {
            todaySlotC = element;
          }
        },
      );
    } else {
      // pass in the original value
      populateSlotCPattern().asMap().forEach(
        (index, element) {
          if (element.itemMapID == todayMapID) {
            todaySlotC = element;
          }
        },
      );
    }
    // print("todaySlotC: " + todaySlotC.itemMapName.toString());

    dayStock.clear();
    dayStock.add(todaySlotAandB.stockA);
    dayStock.add(todaySlotAandB.stockB);
    dayStock.add(todaySlotC.itemMapName);
    return dayStock;
  }
}

enum STOCK_ITEM {
  // Slot A and B items
  BARREL_OF_BAIT,
  TANGLED_FISHBOWL,
  BROKEN_FISHING_ROD,
  SMALL_GOEBIE_BURIAL_CHARM,
  GOEBIE_BURIAL_CHARM,
  MENAPHITE_GIFT_OFFERING_SMALL,
  MENAPHITE_GIFT_OFFERING_MEDIUM,
  UNSTABLE_AIR_RUNE,
  ANIMA_CRYSTAL,
  SLAYER_VIP_COUPON,
  DISTRACTION_AND_DIVERSION_DAILY,
  UNFOCUSED_DAMAGE_ENHANCER,
  SACRED_CLAY,
  SHATTERED_ANIMA,
  ADVANCED_PULSE_CORE,
  LIVID_PLANT,
  GIFT_FOR_THE_REAPER,
  SILVERHAWK_DOWN,

  //Slot C Items
  DEATHTOUCHED_DART,
  UNFOCUSED_REWARD_ENHANCER,
  STARVED_ANCIENT_EFFIGY,
  MESSAGE_IN_A_BOTTLE,
  LARGE_GOEBIE_BURIAL_CHARM,
  DISTRACTION_AND_DIVERSION_MONTHLY,
  HARMONIC_DUST,
  DISTRACTION_AND_DIVERSION_WEEKLY,
  DRAGONKIN_LAMP,
  MENAPHITE_GIFT_OFFERING_LARGE,
  DUNGEONEERING_WILDCARD,
  CRYSTAL_TRISKELION,
  TAIJU,
}

extension STOCK_ITEM_Extension on STOCK_ITEM {
  String get imageURL {
    switch (this) {
      case STOCK_ITEM.BARREL_OF_BAIT:
        return "barrel_of_bait.png";
      case STOCK_ITEM.TANGLED_FISHBOWL:
        return "Tangled_fishbowl.png";
      case STOCK_ITEM.BROKEN_FISHING_ROD:
        return "Broken_fishing_rod.png";
      case STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM:
        return "Small_goebie_burial_charm.png";
      case STOCK_ITEM.GOEBIE_BURIAL_CHARM:
        return "Goebie_burial_charm.png";
      case STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL:
        return "Menaphite_gift_offering_(small).png";
      case STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM:
        return "Menaphite_gift_offering_(medium).png";
      case STOCK_ITEM.UNSTABLE_AIR_RUNE:
        return "Unstable_air_rune.png";
      case STOCK_ITEM.ANIMA_CRYSTAL:
        return "Anima_crystal.png";
      case STOCK_ITEM.SLAYER_VIP_COUPON:
        return "Slayer_VIP_Coupon.png";
      case STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY:
        return "D&D_token_(daily).png";
      case STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER:
        return "Unfocused_damage_enhancer.png";
      case STOCK_ITEM.SACRED_CLAY:
        return "Sacred_clay.png";
      case STOCK_ITEM.SHATTERED_ANIMA:
        return "Shattered_anima.png";
      case STOCK_ITEM.ADVANCED_PULSE_CORE:
        return "Advanced_pulse_core.png";
      case STOCK_ITEM.LIVID_PLANT:
        return "Livid_plant.png";
      case STOCK_ITEM.GIFT_FOR_THE_REAPER:
        return "Gift_for_the_Reaper.png";
      case STOCK_ITEM.SILVERHAWK_DOWN:
        return "Silverhawk_down.png";

      //Slot C Items
      case STOCK_ITEM.DEATHTOUCHED_DART:
        return "Deathtouched_dart.png";
      case STOCK_ITEM.UNFOCUSED_REWARD_ENHANCER:
        return "Unfocused_reward_enhancer.png";
      case STOCK_ITEM.STARVED_ANCIENT_EFFIGY:
        return "Starved_ancient_effigy.png";
      case STOCK_ITEM.MESSAGE_IN_A_BOTTLE:
        return "Message_in_a_bottle.png";
      case STOCK_ITEM.LARGE_GOEBIE_BURIAL_CHARM:
        return "Large_goebie_burial_charm.png";
      case STOCK_ITEM.DISTRACTION_AND_DIVERSION_MONTHLY:
        return "D&D_token_(monthly).png";
      case STOCK_ITEM.HARMONIC_DUST:
        return "Harmonic_dust.png";
      case STOCK_ITEM.DISTRACTION_AND_DIVERSION_WEEKLY:
        return "D&D_token_(weekly).png";
      case STOCK_ITEM.DRAGONKIN_LAMP:
        return "Dragonkin_lamp.png";
      case STOCK_ITEM.MENAPHITE_GIFT_OFFERING_LARGE:
        return "Menaphite_gift_offering_(large).png";
      case STOCK_ITEM.DUNGEONEERING_WILDCARD:
        return "Dungeoneering_Wildcard.png";
      case STOCK_ITEM.CRYSTAL_TRISKELION:
        return "Crystal_triskelion.png";
      case STOCK_ITEM.TAIJU:
        return "Taijitu.png";
      default:
        return null;
    }
  }

  String get text {
    switch (this) {
      case STOCK_ITEM.BARREL_OF_BAIT:
        return "Barrel Of Bait";
      case STOCK_ITEM.TANGLED_FISHBOWL:
        return "Tangled Fishbowl";
      case STOCK_ITEM.BROKEN_FISHING_ROD:
        return "Broken Fishing Rod";
      case STOCK_ITEM.SMALL_GOEBIE_BURIAL_CHARM:
        return "Small Goebie Burial Charm";
      case STOCK_ITEM.GOEBIE_BURIAL_CHARM:
        return "Goebie Burial Charm";
      case STOCK_ITEM.MENAPHITE_GIFT_OFFERING_SMALL:
        return "Menaphite Gift Offering (Small)";
      case STOCK_ITEM.MENAPHITE_GIFT_OFFERING_MEDIUM:
        return "Menaphite Gift Offering (Medium)";
      case STOCK_ITEM.UNSTABLE_AIR_RUNE:
        return "Unstable Air Rune";
      case STOCK_ITEM.ANIMA_CRYSTAL:
        return "Anima Crystal";
      case STOCK_ITEM.SLAYER_VIP_COUPON:
        return "Slayer VIP Coupon";
      case STOCK_ITEM.DISTRACTION_AND_DIVERSION_DAILY:
        return "Distraction & Diversion (Daily)";
      case STOCK_ITEM.UNFOCUSED_DAMAGE_ENHANCER:
        return "Unfocused Damage Enhancer";
      case STOCK_ITEM.SACRED_CLAY:
        return "Sacred Clay";
      case STOCK_ITEM.SHATTERED_ANIMA:
        return "Shattered Anima";
      case STOCK_ITEM.ADVANCED_PULSE_CORE:
        return "Advanced Pulse Core";
      case STOCK_ITEM.LIVID_PLANT:
        return "Livid Plant";
      case STOCK_ITEM.GIFT_FOR_THE_REAPER:
        return "Gift For The Reaper";
      case STOCK_ITEM.SILVERHAWK_DOWN:
        return "Silverhawk Down";

      //Slot C Items
      case STOCK_ITEM.DEATHTOUCHED_DART:
        return "Deathtouched Dart";
      case STOCK_ITEM.UNFOCUSED_REWARD_ENHANCER:
        return "Unfocused Reward Enhancer";
      case STOCK_ITEM.STARVED_ANCIENT_EFFIGY:
        return "Starved Ancient Effigy";
      case STOCK_ITEM.MESSAGE_IN_A_BOTTLE:
        return "Message In A Bottle";
      case STOCK_ITEM.LARGE_GOEBIE_BURIAL_CHARM:
        return "Large Goebie Burial Charm";
      case STOCK_ITEM.DISTRACTION_AND_DIVERSION_MONTHLY:
        return "Distraction & Diversion (Monthly)";
      case STOCK_ITEM.HARMONIC_DUST:
        return "Harmonic Dust";
      case STOCK_ITEM.DISTRACTION_AND_DIVERSION_WEEKLY:
        return "Distraction & Diversion (Weekly)";
      case STOCK_ITEM.DRAGONKIN_LAMP:
        return "Dragonkin Lamp";
      case STOCK_ITEM.MENAPHITE_GIFT_OFFERING_LARGE:
        return "Menaphite Gift Offering (Large)";
      case STOCK_ITEM.DUNGEONEERING_WILDCARD:
        return "Dungeoneering Wildcard";
      case STOCK_ITEM.CRYSTAL_TRISKELION:
        return "Crystal Triskelion";
      case STOCK_ITEM.TAIJU:
        return "Taiju";
      default:
        return null;
    }
  }
}
