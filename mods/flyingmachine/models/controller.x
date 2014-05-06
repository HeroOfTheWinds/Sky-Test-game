xof 0303txt 0032

template XSkinMeshHeader {
  <3cf169ce-ff7c-44ab-93c0-f78f62d172e2>
  WORD nMaxSkinWeightsPerVertex;
  WORD nMaxSkinWeightsPerFace;
  WORD nBones;
}

template SkinWeights {
  <6f0d123b-bad2-4167-a0d0-80224f25fabb>
  STRING transformNodeName;
  DWORD nWeights;
  array DWORD vertexIndices[nWeights];
  array float weights[nWeights];
  Matrix4x4 matrixOffset;
}

Frame Root {
  FrameTransformMatrix {
     1.000000, 0.000000, 0.000000, 0.000000,
     0.000000, 0.000000, 1.000000, 0.000000,
     0.000000, 1.000000,-0.000000, 0.000000,
     0.000000, 0.000000, 0.000000, 1.000000;;
  }
  Frame Armature {
    FrameTransformMatrix {
       1.000000, 0.000000, 0.000000, 0.000000,
       0.000000, 0.000000,-1.000000, 0.000000,
      -0.000000, 1.000000, 0.000000, 0.000000,
       0.000000, 0.000000, 0.000000, 1.000000;;
    }
    Frame Armature_Bone {
      FrameTransformMatrix {
         1.000000, 0.000000, 0.000000, 0.000000,
         0.000000, 0.000000, 1.000000, 0.000000,
         0.000000,-1.000000, 0.000000, 0.000000,
         0.000000, 0.000000, 0.000000, 1.000000;;
      }
    } //End of Armature_Bone
  } //End of Armature
  Frame Cube {
    FrameTransformMatrix {
       5.000000, 0.000000, 0.000000, 0.000000,
       0.000000, 5.000000, 0.000000, 0.000000,
       0.000000, 0.000000, 5.000000, 0.000000,
       0.000000, 0.000000, 0.000000, 1.000000;;
    }
    Mesh { //Cube_001 Mesh
      24;
      -1.000000;-1.000000;-1.000000;,
      -1.000000; 1.000000;-1.000000;,
      -1.000000; 1.000000; 1.000000;,
      -1.000000;-1.000000; 1.000000;,
      -1.000000; 1.000000;-1.000000;,
       1.000000; 1.000000;-1.000000;,
       1.000000; 1.000000; 1.000000;,
      -1.000000; 1.000000; 1.000000;,
       1.000000; 1.000000;-1.000000;,
       1.000000;-1.000000;-1.000000;,
       1.000000;-1.000000; 1.000000;,
       1.000000; 1.000000; 1.000000;,
       1.000000;-1.000000;-1.000000;,
      -1.000000;-1.000000;-1.000000;,
      -1.000000;-1.000000; 1.000000;,
       1.000000;-1.000000; 1.000000;,
       1.000000;-1.000000;-1.000000;,
       1.000000; 1.000000;-1.000000;,
      -1.000000; 1.000000;-1.000000;,
      -1.000000;-1.000000;-1.000000;,
      -1.000000;-1.000000; 1.000000;,
      -1.000000; 1.000000; 1.000000;,
       1.000000; 1.000000; 1.000000;,
       1.000000;-1.000000; 1.000000;;
      6;
      4;0;1;2;3;,
      4;4;5;6;7;,
      4;8;9;10;11;,
      4;12;13;14;15;,
      4;16;17;18;19;,
      4;20;21;22;23;;
      MeshNormals { //Cube_001 Normals
        24;
        -1.000000; 0.000000; 0.000000;,
        -1.000000; 0.000000; 0.000000;,
        -1.000000; 0.000000; 0.000000;,
        -1.000000; 0.000000; 0.000000;,
         0.000000; 1.000000;-0.000000;,
         0.000000; 1.000000;-0.000000;,
         0.000000; 1.000000;-0.000000;,
         0.000000; 1.000000;-0.000000;,
         1.000000; 0.000000;-0.000000;,
         1.000000; 0.000000;-0.000000;,
         1.000000; 0.000000;-0.000000;,
         1.000000; 0.000000;-0.000000;,
         0.000000;-1.000000; 0.000000;,
         0.000000;-1.000000; 0.000000;,
         0.000000;-1.000000; 0.000000;,
         0.000000;-1.000000; 0.000000;,
        -0.000000; 0.000000;-1.000000;,
        -0.000000; 0.000000;-1.000000;,
        -0.000000; 0.000000;-1.000000;,
        -0.000000; 0.000000;-1.000000;,
        -0.000000; 0.000000; 1.000000;,
        -0.000000; 0.000000; 1.000000;,
        -0.000000; 0.000000; 1.000000;,
        -0.000000; 0.000000; 1.000000;;
        6;
        4;0;1;2;3;,
        4;4;5;6;7;,
        4;8;9;10;11;,
        4;12;13;14;15;,
        4;16;17;18;19;,
        4;20;21;22;23;;
      } //End of Cube_001 Normals
      MeshMaterialList { //Cube_001 Material List
        1;
        1;
        0;;
        Material Default_Material {
           0.800000; 0.800000; 0.800000; 0.800000;;
           96.078431;
           0.500000; 0.500000; 0.500000;;
           0.000000; 0.000000; 0.000000;;
        }
      } //End of Cube_001 Material List
    } //End of Cube_001 Mesh
  } //End of Cube
} //End of Root Frame
