class ApiRoutes {
// Manager
  static const loginManager = '/manager/login'; // post
  static const restaurantPost = '/restaurant'; // post
  static const restaurantPut = '/restaurant/<id>'; // put
  static const foodPost = '/restaurant/<id>/foods'; // post
  static const foodDelete = '/restaurant/<id>/foods/<id>'; // delete
  static const foodPut = '/restaurant/<id>/foods/<id>'; // put
  static const orderPut = '/orders/<id>'; // put
  static const commentsPut = '/restaurant/<id>/foods/<id>/comments/<id>'; // put

// User
  static const loginUser = '/user/login'; // post
  static const userProfile = '/user/<id>/profile'; // put
  static const searchFood = '/search/food'; // get
  static const searchRestaurant = '/search/restaurant'; // get
  static const searchArea = '/search/area'; // get
  static const ordersPost = '/orders'; // post
  static const ordersStatus = '/orders/<id>/status'; // get
  static const commtentsPost = '/restaurant/<id>/foods/<id>/comments'; // post
}
