class ApiRoutes {
// Manager
  static const loginManager = '/manager/login'; // post
  static const restaurantPost = '/restaurant'; // post
  static const restaurantGet = '/restaurant'; // get
  static const restaurantPut = '/restaurant/{rid}'; // put
  static const foodPost = '/restaurant/{rid}/foods'; // post
  static const foodDelete = '/restaurant/{rid}/foods/{fid}'; // delete
  static const foodPut = '/restaurant/{rid}/foods/{fid}'; // put
  static const orderPut = '/orders/{oid}'; // put
  static const commentsPut = '/restaurant/{rid}/foods/{fid}/comments/{cid}'; // put

// User
  static const loginUser = '/user/login'; // post
  static const userProfile = '/user/{userId}/profile'; // put
  static const searchFood = '/search/food'; // get
  static const searchRestaurant = '/search/restaurant'; // get
  static const searchArea = '/search/area'; // get
  static const ordersPost = '/orders'; // post
  static const ordersStatus = '/orders/{oid}/status'; // get
  static const commtentsPost = '/restaurant/{rid}/foods/{fid}/comments'; // post
}
