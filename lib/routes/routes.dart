import 'package:get/get_navigation/get_navigation.dart';
import 'package:plusone/uis/creativity/createcreativityui.dart';
import 'package:plusone/uis/explore/explorelist/bindings/explorelist_bindings.dart';
import 'package:plusone/uis/explore/exploreview/bindings/exploreview_bindings.dart';
import 'package:plusone/uis/explore/explorelist/exploreui.dart';
import 'package:plusone/uis/explore/exploreview/exploreviewui.dart';
import 'package:plusone/uis/explore/filter/bindings/filterexp_binding.dart';
import 'package:plusone/uis/explore/hostprofile/bindings/hostprofile_binding.dart';
import 'package:plusone/uis/explore/hostprofile/hostprofileui.dart';
import 'package:plusone/uis/explore/map/bindings/mapactivity_binding.dart';
import 'package:plusone/uis/explore/map/mapui.dart';
import 'package:plusone/uis/membership/plans/bindings/plan_binding.dart';
import 'package:plusone/uis/message/chats/bindings/chat_binding.dart';
import 'package:plusone/uis/message/chats/chatui.dart';
import 'package:plusone/uis/message/messagelist/bindings/msglist_binding.dart';
import 'package:plusone/uis/message/messagelist/messagelistui.dart';
import 'package:plusone/uis/message/posupportchat/bindings/posupportchat_binding.dart';
import 'package:plusone/uis/message/posupportchat/plusonesupportchetui.dart';
import 'package:plusone/uis/message/viewnotification/bindings/viewnotifi_binding.dart';
import 'package:plusone/uis/message/viewnotification/viewnotiui.dart';
import 'package:plusone/uis/myactivity/myactivitylist/bindings/myact_binding.dart';
import 'package:plusone/uis/myactivity/upcommingactivity/binding/upcommingactiuser_binding.dart';
import 'package:plusone/uis/myactivity/upcommingactivity/upcomminguseractivityui.dart';
import 'package:plusone/uis/navbar/bindings/navbar_binding.dart';
import 'package:plusone/uis/navbar/navbar.dart';
import 'package:plusone/uis/onbording/codeverify/bindings/codeverify_binding.dart';
import 'package:plusone/uis/onbording/introone/binding/intro_binding.dart';
import 'package:plusone/uis/onbording/introone/intoone.dart';
import 'package:plusone/uis/onbording/login/bindings/loginno_binding.dart';
import 'package:plusone/uis/onbording/register/genderadd/bindings/genderadd_binding.dart';
import 'package:plusone/uis/onbording/register/genderadd/genderaddui.dart';
import 'package:plusone/uis/onbording/register/nameadd/bindings/nameadd_binding.dart';
import 'package:plusone/uis/onbording/register/nameadd/nameaddui.dart';
import 'package:plusone/uis/onbording/register/reg_locdobui/bindings/reglocdob_binding.dart';
import 'package:plusone/uis/onbording/register/reg_locdobui/reglocdobui.dart';
import 'package:plusone/uis/onbording/register/regemail/bindings/regemail_binding.dart';
import 'package:plusone/uis/onbording/register/regemail/regemailui.dart';
import 'package:plusone/uis/profilemain/accountuis/helpcenter/bindings/helpcenter_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/helpcenter/helpcenterui.dart';
import 'package:plusone/uis/profilemain/accountuis/myfavourite/bindings/myfavourite_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/myfavourite/favouritesui.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/bindings/mymembership_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/mymembershipui.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/switchplan/bindings/switchplan_bindings.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/switchplan/switchplanui.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/attendlist/attendlistui.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/attendlist/bindings/attendlist_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/previousactivity/bindings/previousacti_bindings.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/previousactivity/previousactivityui.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/binding/myprofileinnbinding.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/youractivities/attendancereview/attendancereviewui.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/youractivities/attendancereview/bindings/attend_review_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/youractivities/hostactivity_upcomming/bindings/host_upcommiacti_bindings.dart';
import 'package:plusone/uis/profilemain/accountuis/referfrnd/bindings/referfrnd_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/referfrnd/referfrndui.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/bindings/setting_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/activityvisibility/bindings/activityvisibility_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/pushnotification/bindings/pushnotifisetting_binding.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/pushnotification/notificationproui.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingui.dart';
import 'package:plusone/uis/profilemain/bindings/profilemain_bindings.dart';
import 'package:plusone/uis/profilemain/profileui.dart';
import '../uis/creativity/creavity_binding/creativity_binding.dart';
import '../uis/explore/filter/explorefilterui.dart';
import '../uis/membership/plans/plansui.dart';
import '../uis/myactivity/myactivitylist/myactivitieslistui.dart';
import '../uis/onbording/codeverify/codeverifyui.dart';
import '../uis/onbording/login/loginwithnoui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/myprofileui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/activityinterest/activityinterestui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/activityinterest/bindings/activinterest_binding.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/addphoto/addphotoui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/addphoto/bindings/addphoto_binding.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/bio/bindings/bio_binding.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/bio/bioui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/funfact/bindings/funfactpro_binding.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/funfact/funfactui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/language/bindings/languagepro_binding.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/language/languagesproui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/location/bindings/location_binding.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/location/locationproui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/occupation/bindings/occupation_binding.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/occupation/occupationui.dart';
import '../uis/profilemain/accountuis/myprofile/myprofileinner/proallui/verifysocialmedia/getverifyui.dart';
import '../uis/profilemain/accountuis/myprofile/youractivities/hostactivity_upcomming/youractivityviewui.dart';
import '../uis/profilemain/accountuis/settings/settingsalluis/activityvisibility/activityvisibilityui.dart';

class Routes{
  static String initialPage='/';
  static String codeVerify='/codeverify';
  static String loginWithMobNo='/login_with_mobno';
  static String nameAddUi='/name_addui';
  static String genderaddUi='/genderaddui';
  static String regLocDobui='/reglocdobui';
  static String regEmailui='/regemailui';
  static String navbarUi='/navbarui';
  static String exploreUi='/exploreui';
  static String profilemain='/profile_main';
  static String messageListUi='/messagelistui';
  static String myactList='/myactivity_list';
  static String planMemUi='/plan_ui';
  static String myprofileInnUi='/myprofile_innui';
  static String addPhotoProUi='/addphoto_proui';
  static String activityInterestUi='/activityinterestui';
  static String bioUi='/bioui';
  static String locationProUi='/location_proui';
  static String occupationProUi='/occupation_proui';
  static String languageProUi='/language_proui';
  static String funfactProUi='/funfact_proui';
  static String verifySocialMedProUi='/verifysocialmed_proui';
  static String helpcenterProUi='/helpcenter_proui';
  static String myfavProui='/myfav_proui';
  static String mymembershipProUi='/mymembership_proui';
  static String settingProUi='/setting_proui';
  static String referFrndProUi='/referfrnd_proui';
  static String switchPlanProUi='/switchplan_proui';
  static String activityVisibilitySettingUi='/activityvisibility_settingui';
  static String pushNotiSettingUi='/pushnoti_settingui';
  static String createActivityUi='/creatcreativityui';
  static String mapActivityUi='/mapactivityui';
  static String filterExploreUi='/filter_exploreui';
  static String exploreView='/explore_view';
  static String hostProfileUi='/hostprofileui';
  static String chatUi='/chatui';
  static String poSupportChat='/posupport_chat';
  static String viewNotifiUi='/viewnotification_ui';
  static String upcommingUserActiUi='/upcomminguser_activityui';
  static String previousActivityUi='/previousactivity_ui';
  static String attendList='/attend_list';
  static String hostUpcommingActiview='/hostupcommin_activityview';
  static String attendReviewUi='/attend_reviewui';

  static List<GetPage<dynamic>>? listRoutes=[
    GetPage(name: initialPage, page:()=> IntroOneUi(),binding: IntroBinding()),
    GetPage(name: codeVerify, page:()=>CodeVerifyUi(),bindings: [IntroBinding(),CodeverifyBinding(),LoginnoBinding()]),
    GetPage(name: loginWithMobNo, page:()=>LoginWithNoUi(),binding: LoginnoBinding()),
    GetPage(name: nameAddUi, page:()=>NameAddUi(),binding: NameaddBinding()),
    GetPage(name: genderaddUi, page:()=>GenderAddUi(),binding: GenderaddBinding()),
    GetPage(name: regLocDobui, page:()=>RegLocDOBUi(),binding: ReglocdobBinding()),
    GetPage(name: regEmailui, page:()=>RegEmailUi(),binding: RegemailBinding()),
    GetPage(name: navbarUi, page:()=>Navbar(),binding: NavbarBinding()),
    GetPage(name: exploreUi, page:()=>const ExploreUi(),binding: ExploreListBindings()),
    GetPage(name: profilemain, page:()=>const ProfileUi(),binding: ProfilemainBindings()),
    GetPage(name: messageListUi, page:()=>const MessageListUi(),binding: MsglistBinding()),
    GetPage(name: myactList, page:()=>const MyActivitiesListUi(),binding: MyactBinding()),
    GetPage(name: planMemUi, page:()=>const PlansUi(),binding: PlanBinding()),
    GetPage(name: myprofileInnUi, page:()=>MyProfileUi(),binding: MyprofileInnbinding()),
    GetPage(name: addPhotoProUi, page:()=>const AddPhotoUi(),binding: AddphotoBinding()),
    GetPage(name: activityInterestUi, page:()=> ActivityInterestUi(),binding: ActivinterestBinding()),
    GetPage(name: locationProUi, page:()=>LocationProUi(),binding: LocationBinding()),
    GetPage(name: occupationProUi, page:()=>OccupationUi(),binding: OccupationBinding()),
    GetPage(name: languageProUi, page:()=>LanguagesProUi(),binding: LanguageproBinding()),
    GetPage(name: funfactProUi, page:()=>const FunFactUi(),binding: FunFactProBinding()),
    GetPage(name: verifySocialMedProUi, page:()=> GetVerifyUi(),binding: LanguageproBinding()),
    GetPage(name: bioUi, page:()=>BioUi(),binding: BioBinding()),
    GetPage(name: helpcenterProUi, page:()=>HelpCenterUi(),binding: HelpcenterBinding()),
    GetPage(name: myfavProui, page:()=> FavouriteListUi(),binding: MyfavouriteBinding()),
    GetPage(name: mymembershipProUi, page:()=>const MyMemberShipUi(),binding: MymembershipBinding()),
    GetPage(name: settingProUi, page:()=>const SettingUi(),binding: SettingBinding()),
    GetPage(name: referFrndProUi, page:()=>const ReferFrndUi(),binding: ReferFrndBinding()),
    GetPage(name: switchPlanProUi, page:()=>const SwitchPlanUi(),binding: SwitchplanBindings()),
    GetPage(name: activityVisibilitySettingUi, page:()=>const ActivityVisibility(),binding: ActivityvisibilityBinding()),
    GetPage(name: pushNotiSettingUi, page:()=>const NotificationProUi(),binding: PushnotifisettingBinding()),
    GetPage(name: createActivityUi, page:()=>const CreateActivityUi(),binding: CreativityBinding()),
    GetPage(name: mapActivityUi, page:()=>const MapActivityUi(),binding: MapActivityBinding()),
    GetPage(name: filterExploreUi, page:()=> ExploreFilterUi(),binding:FilterExpBinding()),
    GetPage(name: exploreView, page:()=>ExploreViewUi(),binding:ExploreViewBindings()),
    GetPage(name: hostProfileUi, page:()=>HostProfileUi(),binding:HostProfileBinding()),
    GetPage(name: chatUi, page:()=> ChatUi(),binding:ChatBinding()),
    GetPage(name: poSupportChat, page:()=> PlusOneSupportChetUi(),binding:PoSupportChatBinding()),
    GetPage(name: viewNotifiUi, page:()=> const ViewNotiUi(),binding:ViewnotifiBinding()),
    GetPage(name: upcommingUserActiUi, page:()=>  UpcommingUserActivityUi(),binding:UpCommingActiUserBinding()),
    GetPage(name: previousActivityUi, page:()=>   PreviousActivityUi(),binding:PreviousActiBindings()),
    GetPage(name: attendList, page:()=>  const AttendListUi(),binding:AttendlistBinding()),
    GetPage(name: hostUpcommingActiview, page:()=> const HostUpcomActivityViewUi(),binding:HostUpcommiActiBindings()),
    GetPage(name: attendReviewUi, page:()=> const AttendanceReviewUi(),binding:AttendReviewBinding()),
  ];
}