package android.src.main.java.nts.com.nts_picker.files;

import android.net.Uri;

public class Selector {
    private String selection;
    private String[] selectionArgs;
    private String sortOrder;
    private String[] projection;
    private Uri uri;

    public Selector(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
        this.selection = selection;
        this.selectionArgs = selectionArgs;
        this.sortOrder = sortOrder;
        this.projection = projection;
        this.uri = uri;
    }

    public String getSelection() {
        return selection;
    }

    public void setSelection(String selection) {
        this.selection = selection;
    }

    public String[] getSelectionArgs() {
        return selectionArgs;
    }

    public void setSelectionArgs(String[] selectionArgs) {
        this.selectionArgs = selectionArgs;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String[] getProjection() {
        return projection;
    }

    public void setProjection(String[] projection) {
        this.projection = projection;
    }

    public Uri getUri() {
        return uri;
    }

    public void setUri(Uri uri) {
        this.uri = uri;
    }
}
