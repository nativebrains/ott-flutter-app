class ApiEndpoints {
  // Server URL
  static const String SERVER_URL = "https://ott-app.nb-stage.one";

  // Base URLs
  static const String IMAGE_PATH = '$SERVER_URL/images/';
  static const String API_URL = '/api/v1/';

  // Array Name
  static const String ARRAY_NAME = 'VIDEO_STREAMING_APP';

  // Endpoints
  static const String HOME_URL = '${API_URL}home';
  static const String LOGIN_URL = '${API_URL}login';
  static const String LOGIN_SOCIAL_URL = '${API_URL}login_social';
  static const String REGISTER_URL = '${API_URL}signup';
  static const String LANGUAGE_URL = '${API_URL}languages';
  static const String GENRE_URL = '${API_URL}genres';
  static const String SHOW_BY_LANGUAGE_URL = '${API_URL}shows_by_language';
  static const String SHOW_BY_GENRE_URL = '${API_URL}shows_by_genre';
  static const String MOVIE_BY_LANGUAGE_URL = '${API_URL}movies_by_language';
  static const String MOVIE_BY_GENRE_URL = '${API_URL}movies_by_genre';
  static const String SPORT_CATEGORY_URL = '${API_URL}sports_category';
  static const String SPORT_BY_CATEGORY_URL = '${API_URL}sports_by_category';
  static const String TV_CATEGORY_URL = '${API_URL}livetv_category';
  static const String TV_BY_CATEGORY_URL = '${API_URL}livetv_by_category';
  static const String MOVIE_DETAILS_URL = '${API_URL}movies_details';
  static const String SPORT_DETAILS_URL = '${API_URL}sports_details';
  static const String TV_DETAILS_URL = '${API_URL}livetv_details';
  static const String SHOW_DETAILS_URL = '${API_URL}show_details';
  static const String EPISODE_LIST_URL = '${API_URL}episodes';
  static const String PLAN_LIST_URL = '${API_URL}subscription_plan';
  static const String PROFILE_URL = '${API_URL}profile';
  static const String EDIT_PROFILE_URL = '${API_URL}profile_update';
  static const String APP_DETAIL_URL = '${API_URL}app_details';
  static const String SEARCH_URL = '${API_URL}search';
  static const String PAYMENT_SETTING_URL = '${API_URL}payment_settings';
  static const String DASH_BOARD_URL = '${API_URL}dashboard';
  static const String TRANSACTION_URL = '${API_URL}transaction_add';
  static const String FORGOT_PASSWORD_URL = '${API_URL}forgot_password';
  static const String STRIPE_TOKEN_URL = '${API_URL}stripe_token_get';
  static const String EPISODE_RECENTLY_URL =
      '${API_URL}episodes_recently_watched';
  static const String ACTOR_DETAILS_URL = '${API_URL}actor_details';
  static const String DIRECTOR_DETAILS_URL = '${API_URL}director_details';
  static const String APPLY_COUPON_URL = '${API_URL}apply_coupon_code';
  static const String ADD_TO_WATCHLIST_URL = '${API_URL}watchlist_add';
  static const String REMOVE_FROM_WATCHLIST_URL = '${API_URL}watchlist_remove';
  static const String MY_WATCHLIST_URL = '${API_URL}my_watchlist';
  static const String BRAIN_TREE_TOKEN_URL = '${API_URL}get_braintree_token';
  static const String BRAIN_TREE_CHECK_OUT_URL = '${API_URL}braintree_checkout';
  static const String HOME_MORE_URL = '${API_URL}home_collections';
  static const String DEVICE_LIST_URL = '${API_URL}user_active_device_list';
  static const String DEVICE_LOGOUT_REMOTE_URL =
      '${API_URL}logout_user_remotely';
  static const String LOGOUT_URL = '${API_URL}logout';
  static const String PRO_PAY_U_HASH_URL = '${API_URL}get_payu_hash_new';
  static const String PAYTM_TXN_URL = '${API_URL}get_paytm_token_id';
  static const String INSTA_MOJO_ORDER_URL = '${API_URL}get_instamojo_order_id';
  static const String CASH_FREE_TOKEN_URL = '${API_URL}get_cashfree_token';
  static const String COIN_GATE_PAYMENT_URL = '${API_URL}coingate_pay';
  static const String COIN_GATE_PAYMENT_STATUS_URL =
      '${API_URL}coingate_payment_status';
  static const String PAYSTACK_TOKEN_URL = '${API_URL}paystack_token_get';
  static const String MOLLIE_PAYMENT_URL = '${API_URL}mollie_pay';
  static const String MOLLIE_PAYMENT_STATUS_URL =
      '${API_URL}mollie_payment_status';
  static const String DELETE_USER_URL = '${API_URL}account_delete';
  static const String FILTER_LIST_URL = '${API_URL}lang_genre_cat_list';
  static const String MOVIE_FILTER_URL = '${API_URL}movies_filter';
  static const String SHOW_FILTER_URL = '${API_URL}shows_filter';
  static const String SPORT_FILTER_URL = '${API_URL}sports_filter';
  static const String TV_FILTER_URL = '${API_URL}livetv_filter';
}
