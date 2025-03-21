import ExpoModulesCore

struct TakePictureOptions: Record {
  @Field
  var id: Int = 0

  @Field
  var quality: Double = 0

  @Field
  var base64: Bool = false

  @Field
  var exif: Bool = false

  @Field
  var mirror: Bool = false

  @Field
  var fastMode: Bool = false

  @Field
  var additionalExif: [String: Any]?

  @Field
  var shutterSound: Bool? = true

  @Field
  var pictureRef: Bool = false
}

struct SavePictureOptions: Record {
  @Field
  var quality: Double = 0

  @Field
  var metadata: [String: Any]? = [:]

  @Field
  var base64: Bool = false
}
