DBC Challenge 8.1

**What are some common HTTP status codes?**

Common HTTP Status codes include:

* 100 Continue: The server has received the request headers and the client should proceed to send the request body (in the case of a request for which a body needs to be sent; for example, a POST request). Sending a large request body to a server after a request has been rejected for inappropriate headers would be inefficient. To have a server check the request's headers, a client must send Expect: 100-continue as a header in its initial request and receive a 100 Continue status code in response before sending the body. The response 417 Expectation Failed indicates the request should not be continued.[2]

* **200 OK**: Standard response for successful HTTP requests. The actual response will depend on the request method used. In a GET request, the response will contain an entity corresponding to the requested resource. In a POST request, the response will contain an entity describing or containing the result of the action.[7]

* **201 Created**: The request has been fulfilled, resulting in the creation of a new resource.[8]

* **202 Accepted**: The request has been accepted for processing, but the processing has not been completed. The request might or might not be eventually acted upon, and may be disallowed when processing occurs.[9]

* **403 Forbidden**: The request was a valid request, but the server is refusing to respond to it. The user might be logged in but does not have the necessary permissions for the resource.

* **404 Not Found**: The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.[37]

* **500 Internal Server Error**: A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.[58]

* **503 Service Unavailable**: The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state.[60]

* **504 Gateway Timeout**: The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.[61]


**What is the difference between a GET request and a POST request? When might each be used?**

GET requests the server to send some data to the client. POST requests send data from the client to the server for processing.

GET requests might be used when requesting HTML, XML, or image data from a server when loading a webpage.

Post requests might be used when sending address and credit card data at an e-store, sending data to be posted on a forum, or uploading an image to an image hosting site.


**Optional bonus question: What is a cookie (the technical kind, not the delicious kind)? How does it relate to HTTP requests?**

HTTP Cookies are small files used to keep track of some kind of state of a users interaction with a server. They can be used to track what's currently in the users shopping cart at an e-shop, to keep track of auto-completion information, to track individual users for statistical analysis and marketing. Cookies can be session only, or persistent.