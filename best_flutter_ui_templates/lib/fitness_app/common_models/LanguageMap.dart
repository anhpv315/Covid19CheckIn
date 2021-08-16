import 'package:best_flutter_ui_templates/fitness_app/util/LocalStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageMap {
  static final Map message = {
    "vi": {
      "loading.check_internet": "Kiểm tra kết nối mạng.",
      "loading.connect_server": "Kết nối tới máy chủ.",
      "loading.connect": "Kết nối sẵn sàng.",
      "loading.server_failed": "Máy chủ hiện đang quá tải hoặc tạm dừng để nâng cấp.\n Vui lòng thử lại sau!",
      "loading.internet_failed": "Kết nối không thành công.\n Vui lòng kiểm tra lại kết nối mạng!",
      "main.search": "Tìm kiếm",
      "main.make_what_you_have": "Có gì làm nấy!",
      "main.let_go": "Tìm món phù hợp",
      "main.top_favorite": "Top yêu thích hôm nay",
      "main.contact": "Liên hệ và góp ý",
      "main.about_us": "Về chúng tôi",
      "main.suggestion_title": "Đưa ra nguyên liệu mà bạn có, gợi ý phù hợp sẽ đến trong tích tắc!",
      "suggestion.pick": "Chọn nguyên liệu",
      "suggestion.guide1": "- Nhập lần lượt từng nguyên liệu bạn có vào ô trống, ấn chọn tên nguyên liệu bạn có.",
      "suggestion.guide2": "- Nguyên liệu đã chọn sẽ xuất hiện ở phía dưới. Click đúp hoặc click vào dấu (x) để xóa nguyên liệu đã chọn.",
      "suggestion.guide3": "- Click nút tìm kiếm sau khi đã nhập đủ nguyên liệu.",
      "suggestion.guide4": "- Việc còn lại cứ để chúng tôi lo.",
      "suggestion.result": "Những gợi ý được đưa ra từ nguyên liệu ",
      "random.5random": "5 món ngẫu nhiên",
      "contact.phone_number": "Số điện thoại",

      "main.home": "Trang chủ",
      "main.info": "Thông tin cá nhân",
      "main.updateInfo": "Thay đổi",
      "main.hisTitle": "Lịch sử check-in gần nhất",
      "main.news": "Tin tức",
      "main.seeMore": "Xem thêm",
      "user.name": "Tên",
      "user.phone": "SĐT",
      "user.add": "Địa chỉ",
      "user.org": "Đơn vị/Tổ chức",
      "code.qrTitle": "Tạo mã QR",
      "code.expired": "Hết hiệu lực trong",
      "code.refresh": "Làm mới QR code",
      "code.desc": "Check in bằng QR code để kiểm soát lịch trình, đảm bảo an toàn của cá nhân và cộng đồng!",
      "code.guide": "Đưa mã QR tới trước camera. Di chuyển điện thoại gần hoặc xa, di chuyển các phía sao cho hình ảnh mã nằm gọn trong vùng quét!"
    },
    "en": {
      "loading.check_internet": "Checking Internet connection.",
      "loading.connect_server": "Connecting to Server.",
      "loading.connect": "Connection is ready.",
      "loading.server_failed": "The server is currently overloaded or paused for an upgrade.\n Please try again later!",
      "loading.internet_failed": "Connection failed.\n Please check your network connection!",
      "main.search": "Search",
      "main.make_what_you_have": "Cook what you have!",
      "main.let_go": "Let's go",
      "main.top_favorite": "Top favorites today",
      "main.contact": "Contact and contribute",
      "main.about_us": "About us",
      "main.suggestion_title": "Select the ingredients you have, the right hints will come in no time!",
      "suggestion.pick": "Select the ingredients",
      "suggestion.guide1": "- Enter each ingredient you have in turn in the box, click on the name of the matching ingredient.",
      "suggestion.guide2": "- Selected ingredients will appear at the bottom. Double-click or click the (x) to delete selected ingredients.",
      "suggestion.guide3": "- Click the search button after you have entered enough ingredients.",
      "suggestion.guide4": "- The rest is left to us to take care of.",
      "suggestion.result": "Suggestions are given from the ingredients ",
      "random.5random": "5 random dishes",
      "contact.phone_number": "Phone number",

      "main.home": "Homepage",
      "main.info": "Personal Information",
      "main.updateInfo": "Update",
      "main.news": "News",
      "main.hisTitle": "Recent check-in history",
      "main.seeMore": "See More",
      "user.name": "Name",
      "user.phone": "Phone number",
      "user.add": "Address",
      "user.org": "Organization",
      "code.qrTitle": "Generated QR Code",
      "code.expired": "Code expired in",
      "code.refresh": "Fresh QR code",
      "code.desc": "Check in by QR code to control the travel schedule, ensure the safety of individuals and the community!",
      "code.guide": "Bring the QR code to the front of the camera. Move the phone near or far, moving the sides so that the code image fits in the scanning area!"
    },
    "ko": {
      "loading.check_internet": "Checking Internet connection.",
      "loading.connect_server": "Connecting to Server.",
      "loading.connect": "Connection is ready.",
      "loading.server_failed": "The server is currently overloaded or paused for an upgrade.\n Please try again later!",
      "loading.internet_failed": "Connection failed.\n Please check your network connection!",
      "main.search": "Search",
      "main.make_what_you_have": "Cook what you have!",
      "main.let_go": "Let's go",
      "main.top_favorite": "Top favorites today",
      "main.contact": "Contact and contribute",
      "main.about_us": "About us",
      "main.suggestion_title": "Select the ingredients you have, the right hints will come in no time!",
      "suggestion.pick": "Select the ingredients",
      "suggestion.guide1": "- Enter each ingredient you have in turn in the box, click on the name of the matching ingredient.",
      "suggestion.guide2": "- Selected ingredients will appear at the bottom. Double-click or click the (x) to delete selected ingredients.",
      "suggestion.guide3": "- Click the search button after you have entered enough ingredients.",
      "suggestion.guide4": "- The rest is left to us to take care of.",
      "suggestion.result": "Suggestions are given from the ingredients ",
      "random.5random": "5 random dishes",
      "contact.phone_number": "Phone number"
    }
  };
  static String lang = '';

  static String getValue(String key){
    lang = LocalStorage.localStorage.getString('lang');
    return message[lang][key];
  }
}