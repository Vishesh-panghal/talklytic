// // ignore_for_file: non_constant_identifier_names

// import 'package:talklytic/Data/GIPHY/Trending_Modal/imageModal.dart';
// import 'package:talklytic/Data/GIPHY/Trending_Modal/pagination.dart';

// import 'UserModal.dart';

// class MainDataModal {
//   List<GifData> data;
//   Pagination pagination;
//   Meta meta;
//   MainDataModal(
//       {required this.data, required this.pagination, required this.meta});
//   factory MainDataModal.fromJson(Map<String, dynamic> json) {
//     List<GifData> mUser = [];
//     for (Map<String, dynamic> eachUser in json['data']) {
//       mUser.add(GifData.fromJson(eachUser));
//     }
//     return MainDataModal(
//       data: mUser,
//       pagination: json['pagination'],
//       meta: json['meta'],
//     );
//   }
// }

// class GifData {
//   String type;
//   String id;
//   String url;
//   String slug;
//   String bitly_gif_url;
//   String bitly_url;
//   String embed_url;
//   String username;
//   String title;
//   String source;
//   String rating;
//   String content_url;
//   String source_tld;
//   String source_post_url;
//   String import_datetime;
//   String trending_datetime;
//   String analytics_response_payload;
//   bool is_sticker;
//   Image images;
//   User user;
//   Analytics analytics;
//   GifData({
//     required this.analytics,
//     required this.analytics_response_payload,
//     required this.bitly_gif_url,
//     required this.bitly_url,
//     required this.content_url,
//     required this.embed_url,
//     required this.id,
//     required this.images,
//     required this.import_datetime,
//     required this.is_sticker,
//     required this.rating,
//     required this.slug,
//     required this.source,
//     required this.source_post_url,
//     required this.source_tld,
//     required this.title,
//     required this.trending_datetime,
//     required this.type,
//     required this.url,
//     required this.user,
//     required this.username,
//   });
//   factory GifData.fromJson(Map<String, dynamic> json) {
//     return GifData(
//       analytics_response_payload: json['analytics_response_payload'],
//       bitly_gif_url: json['bitly_gif_url'],
//       bitly_url: json['bitly_url'],
//       content_url: json['content_url'],
//       embed_url: json['embed_url'],
//       id: json['id'],
//       import_datetime: json['import_datetime'],
//       is_sticker: json['is_sticker'],
//       rating: json['rating'],
//       slug: json['slug'],
//       source: json['source'],
//       source_post_url: json['source_post_url'],
//       source_tld: json['source_tld'],
//       title: json['title'],
//       trending_datetime: json['trending_datetime'],
//       type: json['type'],
//       url: json['url'],
//       username: json['username'],
//       analytics: Analytics.fromJson(json['analytics']),
//       images: Image.fromJson(json['images']),
//       user: User.fromJson(json['user']),
//     );
//   }
// }



// To parse this JSON data, do

//     final mainDataModal = mainDataModalFromJson(jsonString);

import 'dart:convert';

MainDataModal mainDataModalFromJson(String str) => MainDataModal.fromJson(json.decode(str));

String mainDataModalToJson(MainDataModal data) => json.encode(data.toJson());

class MainDataModal {
    List<Datum> data;
    Pagination pagination;
    Meta meta;

    MainDataModal({
        required this.data,
        required this.pagination,
        required this.meta,
    });

    factory MainDataModal.fromJson(Map<String, dynamic> json) => MainDataModal(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "meta": meta.toJson(),
    };
}

class Datum {
    Type type;
    String id;
    String url;
    String slug;
    String bitlyGifUrl;
    String bitlyUrl;
    String embedUrl;
    String username;
    String source;
    String title;
    Rating rating;
    String contentUrl;
    String sourceTld;
    String sourcePostUrl;
    int isSticker;
    DateTime importDatetime;
    dynamic trendingDatetime;
    Images images;
    User? user;
    String analyticsResponsePayload;
    Analytics analytics;

    Datum({
        required this.type,
        required this.id,
        required this.url,
        required this.slug,
        required this.bitlyGifUrl,
        required this.bitlyUrl,
        required this.embedUrl,
        required this.username,
        required this.source,
        required this.title,
        required this.rating,
        required this.contentUrl,
        required this.sourceTld,
        required this.sourcePostUrl,
        required this.isSticker,
        required this.importDatetime,
        required this.trendingDatetime,
        required this.images,
        this.user,
        required this.analyticsResponsePayload,
        required this.analytics,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: typeValues.map[json["type"]]!,
        id: json["id"],
        url: json["url"],
        slug: json["slug"],
        bitlyGifUrl: json["bitly_gif_url"],
        bitlyUrl: json["bitly_url"],
        embedUrl: json["embed_url"],
        username: json["username"],
        source: json["source"],
        title: json["title"],
        rating: ratingValues.map[json["rating"]]!,
        contentUrl: json["content_url"],
        sourceTld: json["source_tld"],
        sourcePostUrl: json["source_post_url"],
        isSticker: json["is_sticker"],
        importDatetime: DateTime.parse(json["import_datetime"]),
        trendingDatetime: json["trending_datetime"],
        images: Images.fromJson(json["images"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        analyticsResponsePayload: json["analytics_response_payload"],
        analytics: Analytics.fromJson(json["analytics"]),
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "id": id,
        "url": url,
        "slug": slug,
        "bitly_gif_url": bitlyGifUrl,
        "bitly_url": bitlyUrl,
        "embed_url": embedUrl,
        "username": username,
        "source": source,
        "title": title,
        "rating": ratingValues.reverse[rating],
        "content_url": contentUrl,
        "source_tld": sourceTld,
        "source_post_url": sourcePostUrl,
        "is_sticker": isSticker,
        "import_datetime": importDatetime.toIso8601String(),
        "trending_datetime": trendingDatetime,
        "images": images.toJson(),
        "user": user?.toJson(),
        "analytics_response_payload": analyticsResponsePayload,
        "analytics": analytics.toJson(),
    };
}

class Analytics {
    Onclick onload;
    Onclick onclick;
    Onclick onsent;

    Analytics({
        required this.onload,
        required this.onclick,
        required this.onsent,
    });

    factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
        onload: Onclick.fromJson(json["onload"]),
        onclick: Onclick.fromJson(json["onclick"]),
        onsent: Onclick.fromJson(json["onsent"]),
    );

    Map<String, dynamic> toJson() => {
        "onload": onload.toJson(),
        "onclick": onclick.toJson(),
        "onsent": onsent.toJson(),
    };
}

class Onclick {
    String url;

    Onclick({
        required this.url,
    });

    factory Onclick.fromJson(Map<String, dynamic> json) => Onclick(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}

class Images {
    FixedHeight original;
    The480WStill downsized;
    The480WStill downsizedLarge;
    The480WStill downsizedMedium;
    DownsizedSmall downsizedSmall;
    The480WStill downsizedStill;
    FixedHeight fixedHeight;
    FixedHeight fixedHeightDownsampled;
    FixedHeight fixedHeightSmall;
    The480WStill fixedHeightSmallStill;
    The480WStill fixedHeightStill;
    FixedHeight fixedWidth;
    FixedHeight fixedWidthDownsampled;
    FixedHeight fixedWidthSmall;
    The480WStill fixedWidthSmallStill;
    The480WStill fixedWidthStill;
    Looping looping;
    The480WStill originalStill;
    DownsizedSmall originalMp4;
    DownsizedSmall preview;
    The480WStill previewGif;
    The480WStill previewWebp;
    DownsizedSmall? hd;
    The480WStill the480WStill;
    DownsizedSmall? the4K;

    Images({
        required this.original,
        required this.downsized,
        required this.downsizedLarge,
        required this.downsizedMedium,
        required this.downsizedSmall,
        required this.downsizedStill,
        required this.fixedHeight,
        required this.fixedHeightDownsampled,
        required this.fixedHeightSmall,
        required this.fixedHeightSmallStill,
        required this.fixedHeightStill,
        required this.fixedWidth,
        required this.fixedWidthDownsampled,
        required this.fixedWidthSmall,
        required this.fixedWidthSmallStill,
        required this.fixedWidthStill,
        required this.looping,
        required this.originalStill,
        required this.originalMp4,
        required this.preview,
        required this.previewGif,
        required this.previewWebp,
        this.hd,
        required this.the480WStill,
        this.the4K,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        original: FixedHeight.fromJson(json["original"]),
        downsized: The480WStill.fromJson(json["downsized"]),
        downsizedLarge: The480WStill.fromJson(json["downsized_large"]),
        downsizedMedium: The480WStill.fromJson(json["downsized_medium"]),
        downsizedSmall: DownsizedSmall.fromJson(json["downsized_small"]),
        downsizedStill: The480WStill.fromJson(json["downsized_still"]),
        fixedHeight: FixedHeight.fromJson(json["fixed_height"]),
        fixedHeightDownsampled: FixedHeight.fromJson(json["fixed_height_downsampled"]),
        fixedHeightSmall: FixedHeight.fromJson(json["fixed_height_small"]),
        fixedHeightSmallStill: The480WStill.fromJson(json["fixed_height_small_still"]),
        fixedHeightStill: The480WStill.fromJson(json["fixed_height_still"]),
        fixedWidth: FixedHeight.fromJson(json["fixed_width"]),
        fixedWidthDownsampled: FixedHeight.fromJson(json["fixed_width_downsampled"]),
        fixedWidthSmall: FixedHeight.fromJson(json["fixed_width_small"]),
        fixedWidthSmallStill: The480WStill.fromJson(json["fixed_width_small_still"]),
        fixedWidthStill: The480WStill.fromJson(json["fixed_width_still"]),
        looping: Looping.fromJson(json["looping"]),
        originalStill: The480WStill.fromJson(json["original_still"]),
        originalMp4: DownsizedSmall.fromJson(json["original_mp4"]),
        preview: DownsizedSmall.fromJson(json["preview"]),
        previewGif: The480WStill.fromJson(json["preview_gif"]),
        previewWebp: The480WStill.fromJson(json["preview_webp"]),
        hd: json["hd"] == null ? null : DownsizedSmall.fromJson(json["hd"]),
        the480WStill: The480WStill.fromJson(json["480w_still"]),
        the4K: json["4k"] == null ? null : DownsizedSmall.fromJson(json["4k"]),
    );

    Map<String, dynamic> toJson() => {
        "original": original.toJson(),
        "downsized": downsized.toJson(),
        "downsized_large": downsizedLarge.toJson(),
        "downsized_medium": downsizedMedium.toJson(),
        "downsized_small": downsizedSmall.toJson(),
        "downsized_still": downsizedStill.toJson(),
        "fixed_height": fixedHeight.toJson(),
        "fixed_height_downsampled": fixedHeightDownsampled.toJson(),
        "fixed_height_small": fixedHeightSmall.toJson(),
        "fixed_height_small_still": fixedHeightSmallStill.toJson(),
        "fixed_height_still": fixedHeightStill.toJson(),
        "fixed_width": fixedWidth.toJson(),
        "fixed_width_downsampled": fixedWidthDownsampled.toJson(),
        "fixed_width_small": fixedWidthSmall.toJson(),
        "fixed_width_small_still": fixedWidthSmallStill.toJson(),
        "fixed_width_still": fixedWidthStill.toJson(),
        "looping": looping.toJson(),
        "original_still": originalStill.toJson(),
        "original_mp4": originalMp4.toJson(),
        "preview": preview.toJson(),
        "preview_gif": previewGif.toJson(),
        "preview_webp": previewWebp.toJson(),
        "hd": hd?.toJson(),
        "480w_still": the480WStill.toJson(),
        "4k": the4K?.toJson(),
    };
}

class The480WStill {
    String height;
    String width;
    String size;
    String url;

    The480WStill({
        required this.height,
        required this.width,
        required this.size,
        required this.url,
    });

    factory The480WStill.fromJson(Map<String, dynamic> json) => The480WStill(
        height: json["height"],
        width: json["width"],
        size: json["size"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "size": size,
        "url": url,
    };
}

class DownsizedSmall {
    String height;
    String width;
    String mp4Size;
    String mp4;

    DownsizedSmall({
        required this.height,
        required this.width,
        required this.mp4Size,
        required this.mp4,
    });

    factory DownsizedSmall.fromJson(Map<String, dynamic> json) => DownsizedSmall(
        height: json["height"],
        width: json["width"],
        mp4Size: json["mp4_size"],
        mp4: json["mp4"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "mp4_size": mp4Size,
        "mp4": mp4,
    };
}

class FixedHeight {
    String height;
    String width;
    String size;
    String url;
    String? mp4Size;
    String? mp4;
    String webpSize;
    String webp;
    String? frames;
    String? hash;

    FixedHeight({
        required this.height,
        required this.width,
        required this.size,
        required this.url,
        this.mp4Size,
        this.mp4,
        required this.webpSize,
        required this.webp,
        this.frames,
        this.hash,
    });

    factory FixedHeight.fromJson(Map<String, dynamic> json) => FixedHeight(
        height: json["height"],
        width: json["width"],
        size: json["size"],
        url: json["url"],
        mp4Size: json["mp4_size"],
        mp4: json["mp4"],
        webpSize: json["webp_size"],
        webp: json["webp"],
        frames: json["frames"],
        hash: json["hash"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "size": size,
        "url": url,
        "mp4_size": mp4Size,
        "mp4": mp4,
        "webp_size": webpSize,
        "webp": webp,
        "frames": frames,
        "hash": hash,
    };
}

class Looping {
    String mp4Size;
    String mp4;

    Looping({
        required this.mp4Size,
        required this.mp4,
    });

    factory Looping.fromJson(Map<String, dynamic> json) => Looping(
        mp4Size: json["mp4_size"],
        mp4: json["mp4"],
    );

    Map<String, dynamic> toJson() => {
        "mp4_size": mp4Size,
        "mp4": mp4,
    };
}

enum Rating {
    G,
    PG
}

final ratingValues = EnumValues({
    "g": Rating.G,
    "pg": Rating.PG
});

enum TrendingDatetimeEnum {
    THE_00000000000000
}

final trendingDatetimeEnumValues = EnumValues({
    "0000-00-00 00:00:00": TrendingDatetimeEnum.THE_00000000000000
});

enum Type {
    GIF
}

final typeValues = EnumValues({
    "gif": Type.GIF
});

class User {
    String avatarUrl;
    String bannerImage;
    String bannerUrl;
    String profileUrl;
    String username;
    String displayName;
    String description;
    String instagramUrl;
    String websiteUrl;
    bool isVerified;

    User({
        required this.avatarUrl,
        required this.bannerImage,
        required this.bannerUrl,
        required this.profileUrl,
        required this.username,
        required this.displayName,
        required this.description,
        required this.instagramUrl,
        required this.websiteUrl,
        required this.isVerified,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
        bannerImage: json["banner_image"],
        bannerUrl: json["banner_url"],
        profileUrl: json["profile_url"],
        username: json["username"],
        displayName: json["display_name"],
        description: json["description"],
        instagramUrl: json["instagram_url"],
        websiteUrl: json["website_url"],
        isVerified: json["is_verified"],
    );

    Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "banner_image": bannerImage,
        "banner_url": bannerUrl,
        "profile_url": profileUrl,
        "username": username,
        "display_name": displayName,
        "description": description,
        "instagram_url": instagramUrl,
        "website_url": websiteUrl,
        "is_verified": isVerified,
    };
}

class Meta {
    int status;
    String msg;
    String responseId;

    Meta({
        required this.status,
        required this.msg,
        required this.responseId,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["status"],
        msg: json["msg"],
        responseId: json["response_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "response_id": responseId,
    };
}

class Pagination {
    int totalCount;
    int count;
    int offset;

    Pagination({
        required this.totalCount,
        required this.count,
        required this.offset,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["total_count"],
        count: json["count"],
        offset: json["offset"],
    );

    Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "count": count,
        "offset": offset,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
