"use strict";
/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.queryHuggingFace = void 0;
const firebase_functions_1 = require("firebase-functions");
const https_1 = require("firebase-functions/https");
const params_1 = require("firebase-functions/params");
const logger = __importStar(require("firebase-functions/logger"));
// Start writing functions
// https://firebase.google.com/docs/functions/typescript
(0, firebase_functions_1.setGlobalOptions)({ maxInstances: 10 });
const huggingFaceToken = (0, params_1.defineSecret)("HUGGING_FACE_TOKEN");
exports.queryHuggingFace = (0, https_1.onRequest)({
    secrets: [huggingFaceToken],
}, async (request, response) => {
    // Enable CORS
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
    response.set("Access-Control-Allow-Headers", "Content-Type, Authorization");
    if (request.method === "OPTIONS") {
        response.status(204).send("");
        return;
    }
    if (request.method !== "POST") {
        response.status(405).send("Method not allowed");
        return;
    }
    const { prompt } = request.body;
    if (!prompt) {
        response.status(400).send("Prompt is required");
        return;
    }
    const apiKey = huggingFaceToken.value;
    const modelId = "falan42/llama_lora_8b_medical_HealthcareMagictr2_gguf";
    const url = `https://api-inference.huggingface.co/models/${modelId}`;
    try {
        const hfResponse = await fetch(url, {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${apiKey}`,
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                inputs: prompt,
                parameters: { max_new_tokens: 100 },
            }),
        });
        if (!hfResponse.ok) {
            const errorText = await hfResponse.text();
            logger.error("Hugging Face API error", {
                status: hfResponse.status,
                body: errorText,
            });
            response.status(hfResponse.status).send(errorText);
            return;
        }
        const data = await hfResponse.json();
        let generatedText = "";
        if (Array.isArray(data) && data.length > 0) {
            generatedText = data[0].generated_text || "";
        }
        else if (data.error) {
            response.status(500).send(`Model error: ${data.error}`);
            return;
        }
        response.json({ generated_text: generatedText });
    }
    catch (error) {
        logger.error("Error querying Hugging Face", error);
        response.status(500).send("Internal server error");
    }
});
//# sourceMappingURL=index.js.map