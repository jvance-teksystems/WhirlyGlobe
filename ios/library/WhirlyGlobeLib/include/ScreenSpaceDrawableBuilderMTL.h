/*
 *  ScreenSpaceDrawableBuilderMTL.h
 *  WhirlyGlobeLib
 *
 *  Created by Steve Gifford on 5/16/19.
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

#import "ScreenSpaceDrawableBuilder.h"
#import "BasicDrawableBuilderMTL.h"

namespace WhirlyKit
{
    
/// The Metal version sets up a Uniform buffer
class ScreenSpaceTweakerMTL : public ScreenSpaceTweaker
{
public:
    ScreenSpaceTweakerMTL();
    void tweakForFrame(Drawable *inDraw,RendererFrameInfo *frameInfo);
    
    bool setup;
};
    
/** OpenGL version of ScreenSpaceDrawable Builder
 */
class ScreenSpaceDrawableBuilderMTL : virtual public BasicDrawableBuilderMTL, virtual public ScreenSpaceDrawableBuilder
{
public:
    ScreenSpaceDrawableBuilderMTL(const std::string &name);
    
    virtual void Init(bool hasMotion,bool hasRotation, bool buildAnyway = false);
    
    ScreenSpaceTweaker *makeTweaker();
    
    /// Fill out and return the drawable
    virtual BasicDrawable *getDrawable();
};
    
}
