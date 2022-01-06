package android.src.main.java.nts.com.nts_picker.files;

/*
 Created by Thanh Son on 30/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
public class MediaFile {
    private String path;
    private String mediaType;

    public MediaFile(String path, String mediaType) {
        this.path = path;
        this.mediaType = mediaType;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType(String mediaType) {
        this.mediaType = mediaType;
    }

    @Override
    public String toString() {
        return "{" +
                "\"path\":\"" + path + '"' +
                ", \"mediaType\":\"" + mediaType + '"' +
                '}';
    }
}
