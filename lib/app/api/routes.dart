// Manager
const loginManager = '/manager/login'; // post
const restaurantPost = '/restaurant'; // post
const restaurantPut = '/restaurant/<id>'; // put
const foodPost = '/restaurant/<id>/foods'; // post
const foodDelete = '/restaurant/<id>/foods/<id>'; // delete
const foodPut = '/restaurant/<id>/foods/<id>'; // put
const orderPut = '/orders/<id>'; // put
const commentsPut = '/restaurant/<id>/foods/<id>/comments/<id>'; // put

// User
const loginUser = '/user/login';  // post
const userProfile = '/user/<id>/profile'; // put
const searchFood = '/search/food';  // get
const searchRestaurant = '/search/restaurant'; // get
const searchArea = '/search/area';  // get
const ordersPost = '/orders'; // post
const ordersStatus = '/orders/<id>/status'; // get
const commtentsPost = '/restaurant/<id>/foods/<id>/comments'; // post
