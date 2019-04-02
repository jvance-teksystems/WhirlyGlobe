/*
 *  ImageTile_iOS.h
 *  WhirlyGlobeLib
 *
 *  Created by Steve Gifford on 2/14/19.
 *  Copyright 2011-2019 mousebird consulting
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

#import "ImageTile_iOS.h"
#import "RawData_NSData.h"
#import "UIImage+Stuff.h"

namespace WhirlyKit
{
    
ImageTile_iOS::ImageTile_iOS()
: imageStuff(nil), tex(NULL)
{
}

ImageTile_iOS::~ImageTile_iOS()
{
    imageStuff = nil;
}
    
void ImageTile_iOS::clearTexture()
{
    tex = NULL;
}

Texture *ImageTile_iOS::buildTexture()
{
    if (tex)
        return tex;
    
    int destWidth = targetWidth;
    int destHeight = targetHeight;
    if (destWidth <= 0)
        destWidth = width;
    if (destHeight <= 0)
        destHeight = height;
    
    // We need this to be square.  Because duh.
    if (destWidth != destHeight)
    {
        int size = std::max(destWidth,destHeight);
        destWidth = destHeight = size;
    }
    switch (type) {
        case MaplyImgTypeImage:
        {
            NSData *rawData = [(UIImage *)imageStuff rawDataScaleWidth:destWidth height:destHeight border:0];

            tex = new Texture("ImageTile_iOS",RawDataRef(new RawNSDataReader(rawData)),false);
            tex->setWidth(destWidth);
            tex->setHeight(destHeight);
        }
            break;
        case MaplyImgTypeDataUIKitRecognized:
        {
            UIImage *texImage = [UIImage imageWithData:(NSData *)imageStuff];
            if (destWidth <= 0)
                destWidth = (int)CGImageGetWidth(texImage.CGImage);
            if (destHeight <= 0)
                destHeight = (int)CGImageGetHeight(texImage.CGImage);

            NSData *rawData = [texImage rawDataScaleWidth:destWidth height:destHeight border:0];
            tex = new Texture("ImageTile_iOS",RawDataRef(new RawNSDataReader(rawData)),false);
            tex->setWidth(destWidth);
            tex->setHeight(destHeight);
        }
            break;
        case MaplyImgTypeDataPKM:
            tex = new Texture("ImageTile_iOS");
            tex->setPKMData(RawDataRef(new RawNSDataReader((NSData *)imageStuff)));
            tex->setWidth(destWidth);
            tex->setHeight(destHeight);
            break;
        case MaplyImgTypeDataPVRTC4:
            tex = new Texture("ImageTile_iOS", RawDataRef(new RawNSDataReader((NSData *)imageStuff)),true);
            tex->setWidth(destWidth);
            tex->setHeight(destHeight);
            break;
        case MaplyImgTypeRawImage:
            tex = new Texture("ImageTile_iOS",RawDataRef(new RawNSDataReader((NSData *)imageStuff)),false);
            tex->setWidth(destWidth);
            tex->setHeight(destHeight);
            break;
    }

    return tex;
}
    
Texture *ImageTile_iOS::prebuildTexture()
{
    if (tex)
        return tex;
    
    tex = buildTexture();
    
    return tex;
}
    
}
