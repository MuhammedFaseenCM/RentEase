import 'package:flutter_gen/gen_l10n/app_localization.dart';

const logintext = "LOGIN";
const logoutText = "Logout";
const welcomeBack = "Welcome back";
const welcomText = "Welcome";
const rupee = '₹';
const forgotpassText = "Forgot password ?";
const signinWithText = "Signin with";
const noAccountText = "Don't have an account?";
const signUpText = "Signup";
const resetPassText = "Reset password";
const mailtoResetPassText = "Enter email address to reset your password";
const categoryText = "select category *";
const titleText = "Title";
const itemdetailsText = " Item details";
const priceText = "Rent price *";
const dayText = "Day";
const weekText = "Week";
const monthText = "Month";
const galleryText = "Gallery";
const cameraText = "Camera";
const chooseText = "Choose your image source";
const idImageText = "Upload ID Image";
const imagesText = "Upload Images";

const upload3imageText = "Upload 3 images*";

const appName = "RentEase";

const wrongText = "Something went wrong!";
const nextText = "Next";

///[Signup page]
const signupText = "Signup";
const fullnameText = "Full name";
const numberText = "Phone number";
const mailText = "Email address";
const passwordText = "Password";
const confirmPassText = "Confirm password";
const locationText = "Location";
const addIDText = "Add ID image*";

///[Validation]

const validNameText = "\t\tEnter a valid name\n";
const validNumberText = "\t\tEnter a valid number\n";
const validEmailText = '\t\tEnter a valid email\n';
const validPassowrdText = "\t\tEnter valid password\n";
const validcharPasswordText = "\t\tEnter atleast 6 characters\n";
const validMatchPassText = "\t\tPassword doesn't match\n";
const validLocationText = "\t\tEnter a valid location\n";
const validDetailsText = "Enter valid details";

const validTitleText = "\t\tEnter a valid title";
const validPriceText = "Enter a valid amount";

///[Drawer]
const signedAsText = "Signed In as";

///[My gadgets]
const myGadgetsText = "My gadgets";
const noGadgetsText = "You have no gadgets";
const termsText = "Terms and Policies";
const aboutText = "About";
const editGadgetText = "Edit gadget";
const warningText = "Are you sure ?";
const confirmText = "Confirm";
const cancelText = "Cancel";
const saveText = "Save";

///[Nav bar]
const homeText = "Home";
const addItemText = "Add item";
const notifyText = "Notifications";
const ordersText = "Orders";
const accText = "Account";

///[Keys in Firebase Firestore]

const nameInMapText = "name";
const emailInMapText = "email";
const firstImageText = 'image1';
const secondImageText = 'image2';
const thirdImageText = 'image3';
const titleInMapText = "title";
const dayPriceInMapText = 'dayPrice';
const weekPriceInMapText = 'weekPrice';
const monthPriceInMapText = 'monthPrice';
const locationInMapText = 'location';
const detailsInMapText = 'details';

///[Null aware texts if data is not available]

const nameNullText = "Name not available";
const titleNullText = "Title not available";
const priceNullText = "Price not available";
const locationNullText = "Unlocated";
const detailNullText = "Details not available";

///[Account page]

const editProfText = "Edit profile";

///[Item screen]

const editItemText = "Edit your item";
const selectPlanText = "Select a plan";
const detailsText = "Details";

///[Plan details]

const dayPlanDetailsText = "Plan valid till 11:59 P.M\non the same day";
const dailyPlanText = "Daily";
const oneDayText = "1 Day";

const weekPlanDetailsText = "Plan validity for 7 days\nfrom your booking day";
const weeklyPlanText = "Weekly";
const sevenWeekText = "7 Days";

const monthPlanDetailsText = "Plan validity for 30 days\nfrom your booking day";
const monthlyPlanText = "Monthly";
const oneMonthText = "30 Days";

const reqSentText = "Request sent to the owner";

///[Categories]

List<String> categories = [
  'Electronics',
  'Clothing',
  'Home appliances',
  'Health and wellness',
  'Gaming',
  'Sports',
  'Automotive',
  'Travel gadgets',
  'Others'
];
List<String> allcategories = [
  'All',
  'Electronics',
  'Clothing',
  'Home appliances',
  'Health and wellness',
  'Gaming',
  'Sports',
  'Automotive',
  'Travel gadgets',
  'Others'
];

List<String> allCategories({required context}) {
  return [
    AppLocalizations.of(context)!.all,
    AppLocalizations.of(context)!.electronics,
    AppLocalizations.of(context)!.clothing,
    AppLocalizations.of(context)!.homeAppliances,
    AppLocalizations.of(context)!.healthAndWellness,
    AppLocalizations.of(context)!.gaming,
    AppLocalizations.of(context)!.sports,
    AppLocalizations.of(context)!.automotive,
    AppLocalizations.of(context)!.travelGadgets,
    AppLocalizations.of(context)!.others
  ];
}
