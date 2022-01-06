package android.src.main.java.nts.com.nts_picker.files;

import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;

public class FilePicker {

    private Selector generate(String folder, String type) {
        Uri uri = null;
        String[] projection = null;
        String selection = null;
        String[] selectionArgs = null;
        String sortOrder = null;
        switch (type) {
            case "image":
                uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
                projection = new String[]{
                        MediaStore.Images.ImageColumns.DATA,
                        MediaStore.Images.ImageColumns.BUCKET_DISPLAY_NAME,
                };
                break;
            case "video":
                uri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
                projection = new String[]{
                        MediaStore.Video.VideoColumns.DATA,
                        MediaStore.Video.VideoColumns.BUCKET_DISPLAY_NAME,
                };
                break;
        }

        if (folder != null) {
            uri = Uri.parse(folder);
        }
        return new Selector(uri, projection, selection, selectionArgs, sortOrder);
    }

    private List<String> getFiles(Context context, String folder, String type) {
        Selector selector = generate(folder, type);

        Cursor cursor = context.getContentResolver().query(
                selector.getUri(),
                selector.getProjection(),
                selector.getSelection(),
                selector.getSelectionArgs(),
                selector.getSortOrder()
        );

        if(cursor == null){
            return new ArrayList<>();
        }

        List<String> listTemp = new ArrayList<>();
        int column_index_data = cursor.getColumnIndexOrThrow(MediaStore.MediaColumns.DATA);
        while (cursor.moveToNext()) {
            String absolutePath = cursor.getString(column_index_data);
            listTemp.add(new MediaFile( absolutePath, type).toString());
        }
        return listTemp;
    }

    public List<String> getListFile(Context context, String folder, String type) {
        if (type == null) throw new NullPointerException("Parameter Type is required!");
        if (type.equals("image") || type.equals("video")) {
            return getFiles(context, folder, type);
        } else if (type.equals("all")) {
            List<String> listTemp = new ArrayList<>();
            listTemp.addAll(getFiles(context, folder, "image"));
            listTemp.addAll(getFiles(context, folder, "video"));
            return listTemp;
        } else {
            throw new RuntimeException("Type " + type + " is not support!");
        }

    }
}
