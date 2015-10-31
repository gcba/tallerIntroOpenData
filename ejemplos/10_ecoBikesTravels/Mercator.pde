  /**
   * Utility class to convert between geo-locations and Cartesian screen coordinates.
   * Can be used with a bounding box defining the map section.
   *
   * (c) 2011 Till Nagel, tillnagel.com
   */
  public class MercatorMap {
    
    public static final float DEFAULT_TOP_LATITUDE = 80;
    public static final float DEFAULT_BOTTOM_LATITUDE = -80;
    public static final float DEFAULT_LEFT_LONGITUDE = -180;
    public static final float DEFAULT_RIGHT_LONGITUDE = 180;
    
    /** Horizontal dimension of this map, in pixels. */
    protected float mapScreenWidth;
    /** Vertical dimension of this map, in pixels. */
    protected float mapScreenHeight;
  
    /** Northern border of this map, in degrees. */
    protected float topLatitude;
    /** Southern border of this map, in degrees. */
    protected float bottomLatitude;
    /** Western border of this map, in degrees. */
    protected float leftLongitude;
    /** Eastern border of this map, in degrees. */
    protected float rightLongitude;
  
    private float topLatitudeRelative;
    private float bottomLatitudeRelative;
    private float leftLongitudeRadians;
    private float rightLongitudeRadians;
  
    public MercatorMap(float mapScreenWidth, float mapScreenHeight) {
      this(mapScreenWidth, mapScreenHeight, DEFAULT_TOP_LATITUDE, DEFAULT_BOTTOM_LATITUDE, DEFAULT_LEFT_LONGITUDE, DEFAULT_RIGHT_LONGITUDE);
    }
    
    public MercatorMap(float mapScreenWidth, float mapScreenHeight, float topLatitude, float bottomLatitude, float leftLongitude, float rightLongitude) {
      this.mapScreenWidth = mapScreenWidth;
      this.mapScreenHeight = mapScreenHeight;
      this.topLatitude = topLatitude;
      this.bottomLatitude = bottomLatitude;
      this.leftLongitude = leftLongitude;
      this.rightLongitude = rightLongitude;
  
      this.topLatitudeRelative = getScreenYRelative(topLatitude);
      this.bottomLatitudeRelative = getScreenYRelative(bottomLatitude);
      this.leftLongitudeRadians = getRadians(leftLongitude);
      this.rightLongitudeRadians = getRadians(rightLongitude);
    }
  
    public PVector getScreenLocation(PVector geoLocation) {
      float latitudeInDegrees = geoLocation.x;
      float longitudeInDegrees = geoLocation.y;
  
      return new PVector(getScreenX(longitudeInDegrees), getScreenY(latitudeInDegrees));
    }
  
    private float getScreenYRelative(float latitudeInDegrees) {
      return log(tan(latitudeInDegrees / 360f * PI + PI / 4));
    }
  
    protected float getScreenY(float latitudeInDegrees) {
      return mapScreenHeight * (getScreenYRelative(latitudeInDegrees) - topLatitudeRelative) / (bottomLatitudeRelative - topLatitudeRelative);
    }
    
    private float getRadians(float deg) {
      return deg * PI / 180;
    }
  
    protected float getScreenX(float longitudeInDegrees) {
      float longitudeInRadians = getRadians(longitudeInDegrees);
      return mapScreenWidth * (longitudeInRadians - leftLongitudeRadians) / (rightLongitudeRadians - leftLongitudeRadians);
    }
  }