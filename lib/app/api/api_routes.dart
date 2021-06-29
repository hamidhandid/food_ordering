class ApiRoutes {
// Manager
  static const loginManager = '/manager/login'; // post
  static const signupManager = '/manager/signup'; // post
  static const restaurantPost = '/restaurant'; // post
  static const restaurantGet = '/restaurant'; // get
  static const restaurantPut = '/restaurant/{rid}'; // put
  static const foodPost = '/restaurant/{rid}/foods'; // post
  static const foodDelete = '/restaurant/foods/{fid}'; // delete
  static const foodPut = '/restaurant/foods/{fid}'; // put
  static const orderPut = '/orders/{oid}'; // put
  static const commentsPut = '/restaurant/{rid}/foods/{fid}/comments/{cid}'; // put

// User
  static const loginUser = '/user/login'; // post
  static const signupUser = '/user/signup'; // post
  static const userProfile = '/user/profile'; // put
  static const searchFood = '/search'; // get
  static const ordersPost = '/orders/{id}'; // post
  static const ordersPut = '/orders/{id}'; // post
  static const ordersGet = '/orders/{id}'; // get
  static const ordersGetAll = '/orders'; // get
  static const ordersStatus = '/orders/{oid}/status'; // get
  static const connentsPost = '/restaurant/{rid}/foods/{fid}/comments'; // post
}
