//
//  XMGrayFilter.m
//  XWTools
//
//  Created by xuwen_chen on 2020/8/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import "XMGrayFilter.h"

@implementation XMGrayFilter

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGPUImageLuminanceFragmentShaderString = SHADER_STRING
(
 precision highp float;
 
 varying vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 const highp vec3 W = vec3(0.3, 0.3, 0.3);
 
 void main()
 {
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     float luminance = dot(textureColor.rgb, W);
     
     gl_FragColor = vec4(vec3(luminance), textureColor.a);
 }
);
#else
NSString *const kGPUImageLuminanceFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 const vec3 W = vec3(0.3, 0.3, 0.3);
 
 void main()
 {
     vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     float luminance = dot(textureColor.rgb, W);
     
     gl_FragColor = vec4(vec3(luminance), textureColor.a);
 }
);
#endif


- (void)renderToTextureWithVertices:(const GLfloat *)vertices textureCoordinates:(const GLfloat *)textureCoordinates;
{
    if (!currentlyReceivingMonochromeInput)
    {
        [super renderToTextureWithVertices:vertices textureCoordinates:textureCoordinates];
    }
}

//- (void)setInputTexture:(GLuint)newInputTexture atIndex:(NSInteger)textureIndex;
//{
//    [super setInputTexture:newInputTexture atIndex:textureIndex];
//    if (currentlyReceivingMonochromeInput)
//    {
//        [self notifyTargetsAboutNewOutputTexture];
//    }
//}

//- (GLuint)textureForOutput;
//{
//    if (currentlyReceivingMonochromeInput)
//    {
//        return filterSourceTexture;
//    }
//    else
//    {
//        return outputTexture;
//    }
//}

- (BOOL)wantsMonochromeInput;
{
//    return YES;
    return NO;
}

- (BOOL)providesMonochromeOutput;
{
//    return YES;
    return NO;
}

// TODO: Rewrite this based on the new GPUImageFilter implementation
//- (void)informTargetsAboutNewFrameAtTime:(CMTime)frameTime;
//{
//    if (self.frameProcessingCompletionBlock != NULL)
//    {
//        self.frameProcessingCompletionBlock(self, frameTime);
//    }
//
//    for (id<GPUImageInput> currentTarget in targets)
//    {
//        if (currentTarget != self.targetToIgnoreForUpdates)
//        {
//            NSInteger indexOfObject = [targets indexOfObject:currentTarget];
//            NSInteger textureIndex = [[targetTextureIndices objectAtIndex:indexOfObject] integerValue];
//
//            if ([GPUImageContext supportsFastTextureUpload] && preparedToCaptureImage)
//            {
//                [self setInputTextureForTarget:currentTarget atIndex:textureIndex];
//            }
//
//            if (currentlyReceivingMonochromeInput)
//            {
//                [currentTarget setInputRotation:inputRotation atIndex:textureIndex];
//
//                CGSize sizeToRotate = [self outputFrameSize];
//                CGSize rotatedSize = sizeToRotate;
//                if (GPUImageRotationSwapsWidthAndHeight(inputRotation))
//                {
//                    rotatedSize.width = sizeToRotate.height;
//                    rotatedSize.height = sizeToRotate.width;
//                }
//                [currentTarget setInputSize:rotatedSize atIndex:textureIndex];
//            }
//            else
//            {
//                [currentTarget setInputSize:[self outputFrameSize] atIndex:textureIndex];
//            }
//            [currentTarget newFrameReadyAtTime:frameTime atIndex:textureIndex];
//        }
//    }
//}

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageLuminanceFragmentShaderString]))
    {
        return nil;
    }
    
    return self;
}


@end
