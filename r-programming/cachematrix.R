##  Script: cachematrix.R
##  Author: Dennis Barger
##  Data:   6/21/14
##  Description:
##  Caches the inverse operation of a matrix by using the following functions:
##  - makeCacheMatrix():  Creates a special matrix object and caches the object
##  - cacheSolve(): Retrieves value from the cached matrix object.  If no cache, it calculates the inverse
##
## makeCacheMatrix()
##  Creates and caches a special matrix objects to capture the inverse of the matrix:
##  - Function Arguments:  matrix
##  - Initialize cache and set value
##  - Calculate matrix inverse and cache object in parent environment.  
##  - Creates function to set and get inverse value from cached object

makeCacheMatrix <- function(x = matrix()) {
    
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    
    get <- function() x
    setinverse <- function(solve) m <<- solve
    getinverse <- function() m
    list (set = set,
          get = get,
          setinverse = setinverse,
          getinverse = getinverse)
};


##  cacheSolve()
##  Retrieves value from the cached matrix object.  If no cache, then calculate the inverse and return.
##  - Function agruments = matrix objects, calling function agruments
##  - Get value from cached matrix objecgts
##  - Return value if exist
##  - If no cached value, then calculate the inverse of the matrix argument and return

cacheSolve <- function(x, ...) {
    
    # Return cached matrix if value not null
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    
    # If no cache matrix, then assign function matrix argument to local object and calculate the inverse.
    # Cache the inverse value in a matrix object and return the value.
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
};

